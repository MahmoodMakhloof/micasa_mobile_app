import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:shca/modules/auth/models/user.dart';
import 'package:shca/modules/home/models/interface.dart';

part 'group.g.dart';

@JsonSerializable()
class Group extends Equatable {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final List<String> interfaces;
  final List<UserModel> users;
  final UserModel? admin;

  const Group({
    required this.id,
    required this.name,
    required this.admin,
    required this.interfaces,
    required this.users,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        admin
      ];
}
