import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'interface.dart';

part 'group.g.dart';


@JsonSerializable()
class Group extends Equatable {
  @JsonKey(name: "_id")
  final String id;

  final String name;
  final List<Interface> interfaces;


  const Group({
    required this.id,
    required this.name,
    required this.interfaces,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  @override
  List<Object?> get props => [id, name,  interfaces];
}
