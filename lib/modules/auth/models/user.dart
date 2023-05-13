import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  String? id;
  String? fullname;
  String? email;
  String? username;
  String? avatar;
  String? deviceToken;
  String? phone;
  String? gender;
  String? createdAt;

  UserModel({
    this.id,
    this.fullname,
    this.email,
    this.username,
    this.avatar,
    this.deviceToken,
    this.phone,
    this.gender,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Empty user which represents an unauthenticated user.
  static final empty = UserModel(id: "-1", fullname: "", email: "");

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;
}
