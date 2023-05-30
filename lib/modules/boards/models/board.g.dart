// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Board',
      json,
      ($checkedConvert) {
        final val = Board(
          id: $checkedConvert('_id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          model: $checkedConvert('model', (v) => v as String),
          isActive: $checkedConvert('is_active', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id', 'isActive': 'is_active'},
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'model': instance.model,
      'is_active': instance.isActive,
    };
