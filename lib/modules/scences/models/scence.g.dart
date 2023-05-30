// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scence _$ScenceFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Scence',
      json,
      ($checkedConvert) {
        final val = Scence(
          id: $checkedConvert('_id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          events: $checkedConvert('events', (v) => v as Map<String, dynamic>),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id'},
    );

Map<String, dynamic> _$ScenceToJson(Scence instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'events': instance.events,
    };
