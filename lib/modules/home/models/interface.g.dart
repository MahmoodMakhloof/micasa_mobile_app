// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interface.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Interface _$InterfaceFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Interface',
      json,
      ($checkedConvert) {
        final val = Interface(
          id: $checkedConvert('_id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          board: $checkedConvert(
              'board',
              (v) =>
                  v == null ? null : Board.fromJson(v as Map<String, dynamic>)),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$InterfaceTypeEnumMap, v)),
          device: $checkedConvert('device',
              (v) => $enumDecodeNullable(_$InterfaceDevicesEnumMap, v)),
          value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id'},
    );

Map<String, dynamic> _$InterfaceToJson(Interface instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'board': instance.board?.toJson(),
      'type': _$InterfaceTypeEnumMap[instance.type]!,
      'device': _$InterfaceDevicesEnumMap[instance.device],
      'value': instance.value,
    };

const _$InterfaceTypeEnumMap = {
  InterfaceType.DO: 'DO',
  InterfaceType.DI: 'DI',
  InterfaceType.AO: 'AO',
  InterfaceType.AI: 'AI',
};

const _$InterfaceDevicesEnumMap = {
  InterfaceDevices.lamp: 'lamp',
  InterfaceDevices.fan: 'fan',
  InterfaceDevices.ac: 'ac',
  InterfaceDevices.curtain: 'curtain',
  InterfaceDevices.lampshade: 'lampshade',
  InterfaceDevices.door: 'door',
  InterfaceDevices.temperature: 'temperature',
  InterfaceDevices.smoke: 'smoke',
  InterfaceDevices.lock: 'lock',
};
