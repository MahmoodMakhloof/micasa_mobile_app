import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../boards/models/board.dart';

part 'interface.g.dart';

@JsonSerializable()
class Interface extends Equatable {
  @JsonKey(name: "_id")
  final String id;

  String name;
  final Board? board;
  final InterfaceType type;
  final InterfaceDevices? device;
  double? value;

  Interface({
    required this.id,
    required this.name,
    this.board,
    required this.type,
    this.device,
    this.value,
  });

  factory Interface.fromJson(Map<String, dynamic> json) =>
      _$InterfaceFromJson(json);

  Map<String, dynamic> toJson() => _$InterfaceToJson(this);

  @override
  List<Object?> get props => [id, name, board, device, value, type];
}
