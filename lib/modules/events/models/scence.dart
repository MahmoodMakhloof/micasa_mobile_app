import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scence.g.dart';

@JsonSerializable()
class Scence extends Equatable {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final List<Event> events;
  const Scence({
    required this.id,
    required this.name,
    required this.events,
  });

  factory Scence.fromJson(Map<String, dynamic> json) => _$ScenceFromJson(json);

  Map<String, dynamic> toJson() => _$ScenceToJson(this);

  @override
  List<Object> get props => [id, name, events];

  Scence copyWith({
    String? id,
    String? name,
    List<Event>? events,
  }) {
    return Scence(
      id: id ?? this.id,
      name: name ?? this.name,
      events: events ?? this.events,
    );
  }
}

@JsonSerializable()
class Event extends Equatable {
  String? interfaceId;
  double? value;
  Event({
     this.interfaceId,
     this.value,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props => [interfaceId, value];
}
