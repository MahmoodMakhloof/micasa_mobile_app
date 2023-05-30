import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'interface.dart';

part 'group.g.dart';

@JsonSerializable()
class Group extends Equatable {
  @JsonKey(name: "_id")
  final String id;
  final int numberOfDevices;
  final String name;

  const Group({
    required this.id,
    required this.numberOfDevices,
    required this.name,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  @override
  List<Object?> get props => [id, name, numberOfDevices];
}
