// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UserModel',
      json,
      ($checkedConvert) {
        final val = UserModel(
          id: $checkedConvert('_id', (v) => v as String?),
          fullname: $checkedConvert('fullname', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
          username: $checkedConvert('username', (v) => v as String?),
          avatar: $checkedConvert('avatar', (v) => v as String?),
          deviceToken: $checkedConvert('device_token', (v) => v as String?),
          phone: $checkedConvert('phone', (v) => v as String?),
          gender: $checkedConvert('gender', (v) => v as String?),
          createdAt: $checkedConvert('created_at', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': '_id',
        'deviceToken': 'device_token',
        'createdAt': 'created_at'
      },
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'fullname': instance.fullname,
      'email': instance.email,
      'username': instance.username,
      'avatar': instance.avatar,
      'device_token': instance.deviceToken,
      'phone': instance.phone,
      'gender': instance.gender,
      'created_at': instance.createdAt,
    };
