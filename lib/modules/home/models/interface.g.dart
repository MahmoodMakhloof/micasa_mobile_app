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
          icon: $checkedConvert('icon', (v) => v as String),
          board: $checkedConvert(
              'board', (v) => Board.fromJson(v as Map<String, dynamic>)),
          value: $checkedConvert('value', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id'},
    );

Map<String, dynamic> _$InterfaceToJson(Interface instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'board': instance.board.toJson(),
      'icon': instance.icon,
      'value': instance.value,
    };
