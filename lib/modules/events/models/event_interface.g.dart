// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_interface.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventInterface _$EventInterfaceFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'EventInterface',
      json,
      ($checkedConvert) {
        final val = EventInterface(
          interfaceId: $checkedConvert('interface_id', (v) => v as String),
          interfaceName: $checkedConvert('interface_name', (v) => v as String),
          interfaceType: $checkedConvert(
              'interface_type', (v) => $enumDecode(_$InterfaceTypeEnumMap, v)),
          interfaceBoard:
              $checkedConvert('interface_board', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'interfaceId': 'interface_id',
        'interfaceName': 'interface_name',
        'interfaceType': 'interface_type',
        'interfaceBoard': 'interface_board'
      },
    );

Map<String, dynamic> _$EventInterfaceToJson(EventInterface instance) =>
    <String, dynamic>{
      'interface_id': instance.interfaceId,
      'interface_name': instance.interfaceName,
      'interface_type': _$InterfaceTypeEnumMap[instance.interfaceType]!,
      'interface_board': instance.interfaceBoard,
    };

const _$InterfaceTypeEnumMap = {
  InterfaceType.DO: 'DO',
  InterfaceType.DI: 'DI',
  InterfaceType.AO: 'AO',
  InterfaceType.AI: 'AI',
};
