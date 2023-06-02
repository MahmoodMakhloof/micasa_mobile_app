// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Schedule',
      json,
      ($checkedConvert) {
        final val = Schedule(
          id: $checkedConvert('_id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          enabled: $checkedConvert('enabled', (v) => v as bool),
          repeated: $checkedConvert('repeated', (v) => v as bool),
          days: $checkedConvert('days', (v) => v as List<dynamic>),
          time: $checkedConvert('time', (v) => v as String),
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

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'enabled': instance.enabled,
      'repeated': instance.repeated,
      'days': instance.days,
      'time': instance.time,
      'events': instance.events.map((e) => e.toJson()).toList(),
    };
