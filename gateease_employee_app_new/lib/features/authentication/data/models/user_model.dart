// features/authentication/data/models/user_model.dart

import 'package:json_annotation/json_annotation.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  @JsonKey(name: '_id')
  final String id;
  
  UserModel({
    required this.id,
    required String name,
    required String email,
    required String token,
  }) : super(
          name: name,
          email: email,
          token: token,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      // Make sure all required fields are present
      if (json['_id'] == null) {
        throw FormatException('Missing _id in user data');
      }
      if (json['name'] == null) {
        throw FormatException('Missing name in user data');
      }
      if (json['email'] == null) {
        throw FormatException('Missing email in user data');
      }
      if (json['token'] == null) {
        throw FormatException('Missing token in user data');
      }
      
      return _$UserModelFromJson(json);
    } catch (e) {
      print("Error in UserModel.fromJson: $e");
      print("Problematic JSON: $json");
      rethrow;
    }
  }
  
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}