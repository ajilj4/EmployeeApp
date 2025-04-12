import 'package:gateease_employee_app_new/features/authentication/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  final String token;
  final String email;
  final String name;

  UserModel({
    required this.token,
    required this.email,
    required this.name,
  }) : super(email: email, name: name, token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
