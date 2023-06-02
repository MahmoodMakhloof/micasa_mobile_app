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
          model: $checkedConvert(
              'model',
              (v) => v == null
                  ? null
                  : BoardModel.fromJson(v as Map<String, dynamic>)),
          isActive: $checkedConvert('is_active', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id', 'isActive': 'is_active'},
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'model': instance.model?.toJson(),
      'is_active': instance.isActive,
    };

BoardModel _$BoardModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'BoardModel',
      json,
      ($checkedConvert) {
        final val = BoardModel(
          id: $checkedConvert('_id', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          map: $checkedConvert(
              'map',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$InterfaceTypeEnumMap, e))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id'},
    );

Map<String, dynamic> _$BoardModelToJson(BoardModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'description': instance.description,
      'name': instance.name,
      'map': instance.map?.map((e) => _$InterfaceTypeEnumMap[e]!).toList(),
    };

const _$InterfaceTypeEnumMap = {
  InterfaceType.DO: 'DO',
  InterfaceType.DI: 'DI',
  InterfaceType.AO: 'AO',
  InterfaceType.AI: 'AI',
};
