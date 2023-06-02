import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'board.g.dart';

@JsonSerializable()
class Board extends Equatable {
  @JsonKey(name: "_id")
  final String id;

  final String name;
  final BoardModel? model;
  @JsonKey(defaultValue: false)
  final bool isActive;

  const Board({
    required this.id,
    required this.name,
    required this.model,
    required this.isActive,
  });

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  Map<String, dynamic> toJson() => _$BoardToJson(this);

  @override
  List<Object?> get props => [id, name, model, isActive];
}

enum InterfaceType {DO,DI,AO,AI}

@JsonSerializable()
class BoardModel extends Equatable {
  @JsonKey(name: "_id")
  final String id;
  final String description;
  final String name;
  final List<InterfaceType> map;

  const BoardModel({
    required this.id,
    required this.description,
    required this.name,
    required this.map,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  Map<String, dynamic> toJson() => _$BoardModelToJson(this);

  @override
  List<Object?> get props => [id, name, description, map];
}
