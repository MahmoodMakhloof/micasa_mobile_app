import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shca/modules/events/models/scence.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule extends Equatable {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final String? cron;
  final String? datetime;
  final bool enabled;
  final List<Event> events;
  const Schedule({
    required this.id,
    required this.name,
    required this.cron,
    required this.datetime,
    required this.enabled,
    required this.events,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  @override
  @override
  List<Object?> get props {
    return [
      id,
      name,
      datetime,
      cron,
      enabled,
      events,
    ];
  }
}
