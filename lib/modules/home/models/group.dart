import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:shca/modules/auth/models/user.dart';

part 'group.g.dart';

@JsonSerializable()
class Group extends Equatable {
  @JsonKey(name: "_id")
  final String id;
  String name;
   GroupPic image;
  final List<String> interfaces;
  final List<UserModel> users;
  final UserModel? admin;

  Group({
    required this.id,
    required this.name,
    required this.image,
    required this.interfaces,
    required this.users,
    required this.admin,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        admin,
        image,
        interfaces,
        users,
      ];

  Group copyWith({
    String? id,
    String? name,
    GroupPic? image,
    List<String>? interfaces,
    List<UserModel>? users,
    UserModel? admin,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      interfaces: interfaces ?? this.interfaces,
      users: users ?? this.users,
      admin: admin ?? this.admin,
    );
  }
}

@JsonSerializable()
class GroupPic extends Equatable {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final String url;

  const GroupPic({
    required this.id,
    required this.name,
    required this.url,
  });

  factory GroupPic.fromJson(Map<String, dynamic> json) =>
      _$GroupPicFromJson(json);

  Map<String, dynamic> toJson() => _$GroupPicToJson(this);

  @override
  List<Object?> get props => [name, url,id];

  GroupPic copyWith({
    String? id,
    String? name,
    String? url,
  }) {
    return GroupPic(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}
