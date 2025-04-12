import 'package:dio/dio.dart';
import '../models/user_model.dart';

class DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSource(this.dio);

  Future<UserModel> getUser() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/users/1');
    return UserModel.fromJson(response.data);
  }
}
