import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:shca/modules/boards/models/board.dart';

part 'event_interface.g.dart';

@JsonSerializable()
class EventInterface extends Equatable {
  final String interfaceId;
  final String interfaceName;
  final InterfaceType interfaceType;
  final String interfaceBoard;
  const EventInterface({
    required this.interfaceId,
    required this.interfaceName,
    required this.interfaceType,
    required this.interfaceBoard,
  });

  factory EventInterface.fromJson(Map<String, dynamic> json) => _$EventInterfaceFromJson(json);

  Map<String, dynamic> toJson() => _$EventInterfaceToJson(this);

  @override
  List<Object> get props => [interfaceId, interfaceName, interfaceType, interfaceBoard];
}

