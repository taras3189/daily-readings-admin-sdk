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
      fontHeight: json['function'] as double? ?? 1.0,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'fontFamily': instance.fontFamily,
      'fontSize': instance.fontSize,
      'function': instance.function,
      'fontHeight': instance.fontHeight,
    };
