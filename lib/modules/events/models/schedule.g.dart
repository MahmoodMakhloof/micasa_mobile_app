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
          cron: $checkedConvert('cron', (v) => v as String?),
          datetime: $checkedConvert('datetime', (v) => v as String?),
          enabled: $checkedConvert('enabled', (v) => v as bool),
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
      'cron': instance.cron,
      'datetime': instance.datetime,
      'enabled': instance.enabled,
      'events': instance.events.map((e) => e.toJson()).toList(),
    };
