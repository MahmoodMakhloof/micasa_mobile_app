import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'board.g.dart';


@JsonSerializable()
class Board extends Equatable {
  @JsonKey(name: "_id")
  final String id;

  final String name;
  final String image;
  final String model;


  const Board({
    required this.id,
    required this.name,
    required this.model,
    required this.image,
  });

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  Map<String, dynamic> toJson() => _$BoardToJson(this);

  @override
  List<Object?> get props => [id, name, model, image];
}
