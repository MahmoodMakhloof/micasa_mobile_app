import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule extends Equatable {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final bool enabled;
  final bool repeated;
  final List days;
  final String time;
  final Map events;
  const Schedule({
    required this.id,
    required this.name,
    required this.enabled,
    required this.repeated,
    required this.days,
    required this.time,
    required this.events,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  @override

  @override
  List<Object> get props {
    return [
      id,
      name,
      enabled,
      repeated,
      days,
      time,
      events,
    ];
  }
}
