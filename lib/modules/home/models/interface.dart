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
  final InterfaceType type;
  final InterfaceDevices? device;
  final double? value;

   const Interface({
    required this.id,
    required this.name,
    required this.board,
    required this.type,
     this.device,
    required this.value,
  });

  factory Interface.fromJson(Map<String, dynamic> json) =>
      _$InterfaceFromJson(json);

  Map<String, dynamic> toJson() => _$InterfaceToJson(this);

  @override
  List<Object?> get props => [id, name, board,device, value, type];

  Interface copyWith({
    String? id,
    String? name,
    Board? board,
    InterfaceType? type,
    InterfaceDevices? device,
    double? value,
  }) {
    return Interface(
      id: id ?? this.id,
      name: name ?? this.name,
      board: board ?? this.board,
      type: type ?? this.type,
      device: device ?? this.device,
      value: value ?? this.value,
    );
  }
}
