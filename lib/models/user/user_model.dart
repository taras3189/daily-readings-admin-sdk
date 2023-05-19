import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    this.email = '',
    this.fontFamily = 'Roboto',
    this.fontSize = 20.0,
    this.function = '',
    this.fontHeight = 1,
    this.uid = '',
    this.name = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  String email;
  String fontFamily;
  num fontSize;
  String function;
  double fontHeight;
  String uid;
  String name;
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
