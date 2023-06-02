import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shca/core/helpers/networking.dart';
import 'package:shca/modules/auth/utils/networking.dart';
import 'package:utilities/utilities.dart';
import '../../../core/helpers/auth.dart';
import './../models/user.dart';

class AuthenticationRepository {
  final Dio _client;

  AuthenticationRepository({Dio? client}) : _client = client ?? Dio();

  Future<UserModel> createNewUser(UserModel newUser) async {
    try {
      final uri = AuthNetworking.createNewUserUri;
      final customOptions = await getCustomOptions();

      final response = await _client.postUri(
        uri,
        data: {
          "email": newUser.email,
          "avatar": newUser.avatar,
          "fullname": newUser.fullname
        },
        options: commonOptionsWithCustom(customOptions: customOptions),
      );
      final data = response.data['user'] as Map<String, dynamic>;
      final user = UserModel.fromJson(data);
      return user;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<UserModel> getUserData() async {
    try {
      final uri = AuthNetworking.getUserDataUri;
      final customOptions = await getCustomOptions();
      log(customOptions.token!);
      final response = await _client.getUri(uri,
          options: commonOptionsWithCustom(customOptions: customOptions));
      final data = response.data['user'] as Map<String, dynamic>;
      final user = UserModel.fromJson(data);
      return user;
    } on DioError catch (e) {
      final error = decodeDioError(e);
      throw error;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      var cred = await FirebaseAuth.instance.signInWithCredential(credential);
      // user data
      var userData = cred.user;
      // create new user in database in case of new user
      if (cred.additionalUserInfo!.isNewUser) {
        // create new user
        await createNewUser(
          UserModel(
            email: userData!.email,
            fullname: userData.displayName,
            avatar: userData.photoURL,
          ),
        );
      } else {
        // TODO: in case of old user
      }

      return userData!;
    } on FirebaseAuthException catch (e) {
      // TODO: handle this error if no internet connection error
      print(e.message);
    }
    return null;
  }

  Future<void> logout() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      // TODO: handle this error if no internet connection error
      print(e.message);
    }
  }
}
