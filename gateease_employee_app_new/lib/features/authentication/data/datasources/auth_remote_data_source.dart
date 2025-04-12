// features/authentication/data/datasources/auth_remote_data_source.dart

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/user_model.dart';
import '../../../../core/errors/failure.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final baseUrl = dotenv.env['API_BASE_URL'];
      final response = await dio.post(
        '$baseUrl/login',
        data: {'email': email, 'password': password},
      );

      print("API Response: ${response.data}");

      if (response.statusCode == 200) {
        final userJson = response.data['user'] as Map<String, dynamic>?;
        final token = response.data['token'] as String?;

        if (userJson == null || token == null) {
          throw ServerFailure("Invalid response from server");
        }

        // Transform the API response to match your UserModel structure
        final transformedUserData = {
          '_id': userJson['_id'],
          'name': userJson['FirstName'] ?? 'User', // API uses FirstName, not name
          'email': userJson['Email'] ?? '', // API uses Email, not email
          'token': token, // Add the token from response
        };

        final userModel = UserModel.fromJson(transformedUserData);
        return userModel;
      } else {
        throw ServerFailure(response.data['message'] ?? "Login failed");
      }
    } on DioException catch (e) {
      if (e.response?.data is Map<String, dynamic> &&
          e.response?.data['message'] != null) {
        throw ServerFailure(e.response?.data['message']);
      }
      throw ServerFailure("Connection error. Please try again.");
    } catch (e) {
      print("Login error: $e");
      throw ServerFailure("An unexpected error occurred");
    }
  }
}