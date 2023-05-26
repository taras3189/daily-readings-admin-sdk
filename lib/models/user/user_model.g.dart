// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String? ?? '',
      fontFamily: json['fontFamily'] as String? ?? 'Roboto',
      fontSize: json['fontSize'] as num? ?? 20.0,
      function: json['function'] as String? ?? '',
      fontHeight: json['fontHeight'] as double? ?? 1.0,
      uid: json['uid'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      isVerified: json['isVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'fontFamily': instance.fontFamily,
      'fontSize': instance.fontSize,
      'function': instance.function,
      'fontHeight': instance.fontHeight,
      'uid': instance.uid,
      'name': instance.name,
      'avatar': instance.avatar,
      'isVerified': instance.isVerified,
      
    };
