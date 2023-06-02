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
          admin: $checkedConvert(
              'admin',
              (v) => v == null
                  ? null
                  : UserModel.fromJson(v as Map<String, dynamic>)),
          interfaces: $checkedConvert('interfaces',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          users: $checkedConvert(
              'users',
              (v) => (v as List<dynamic>)
                  .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id'},
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'interfaces': instance.interfaces,
      'users': instance.users.map((e) => e.toJson()).toList(),
      'admin': instance.admin?.toJson(),
    };
