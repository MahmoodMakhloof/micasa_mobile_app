import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/generated/assets.gen.dart';
import 'package:shca/modules/auth/blocs/auth_cubit/auth_cubit.dart';
import 'package:slider_button/slider_button.dart';
import 'package:utilities/utilities.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(context.read()),
      child: const _AuthView(),
    );
  }
}

class _AuthView extends StatelessWidget {
  const _AuthView();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: Style.screenSize.height,
            child: Assets.images.png.loginBackground.image(
              fit: BoxFit.cover,
            )),
        Scaffold(
          backgroundColor: Colors.black.withOpacity(0.2),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SliderButton(
                    radius: 15,
                    width: double.infinity,
                    dismissible: false,
                    action: () {
                      context.read<AuthCubit>().signInWithGoogle();
                    },
                    alignLabel: Alignment.center,
                    label: Text(
                      "Slide To Sign In With Google",
                      style: TextStyle(
                          color: CColors.background,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    buttonColor: CColors.primary,
                    backgroundColor: Colors.white,
                    buttonSize: 50,
                    height: 60,
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    )),
                const Space.v40(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
