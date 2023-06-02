import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../boards/models/board.dart';

part 'interface.g.dart';

@JsonSerializable()
class Interface extends Equatable {
  @JsonKey(name: "_id")
  final String id;

  final String name;
  final Board? board;
  final String type;
  final int? value;

  const Interface({
    required this.id,
    required this.name,
    required this.type,
    required this.board,
    required this.value,
  });

  factory Interface.fromJson(Map<String, dynamic> json) =>
      _$InterfaceFromJson(json);

  Map<String, dynamic> toJson() => _$InterfaceToJson(this);

  @override
  List<Object?> get props => [id, name, board, value, type];
}
