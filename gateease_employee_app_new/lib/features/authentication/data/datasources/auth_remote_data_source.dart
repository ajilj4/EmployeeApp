import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';  // Add this import
import 'package:gateease_employee_app_new/features/authentication/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);
  
  @override
  Future<UserModel> login(String email, String password) async {
    final baseUrl = dotenv.env['API_BASE_URL'];
    final response = await dio.get(
      '$baseUrl/login',
      data: {'email': email, 'password': password},
    );
    
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception("Login failed");
    }
  }
}