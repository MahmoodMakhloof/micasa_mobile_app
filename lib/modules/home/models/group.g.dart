// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Group',
      json,
      ($checkedConvert) {
        final val = Group(
          id: $checkedConvert('_id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          interfaces: $checkedConvert(
              'interfaces',
              (v) => (v as List<dynamic>)
                  .map((e) => Interface.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id'},
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'interfaces': instance.interfaces.map((e) => e.toJson()).toList(),
    };
