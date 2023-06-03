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
          events: $checkedConvert(
              'events',
              (v) => (v as List<dynamic>)
                  .map((e) => Event.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id'},
    );

Map<String, dynamic> _$ScenceToJson(Scence instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'events': instance.events.map((e) => e.toJson()).toList(),
    };

Event _$EventFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Event',
      json,
      ($checkedConvert) {
        final val = Event(
          interfaceId: $checkedConvert('interface_id', (v) => v as String?),
          value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {'interfaceId': 'interface_id'},
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'interface_id': instance.interfaceId,
      'value': instance.value,
    };
