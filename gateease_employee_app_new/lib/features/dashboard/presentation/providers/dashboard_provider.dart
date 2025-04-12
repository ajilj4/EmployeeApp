import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/dashboard_remote_data_source.dart';
import '../../data/models/user_model.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider((ref) => Dio());
final dashboardDataSourceProvider = Provider(
    (ref) => DashboardRemoteDataSource(ref.read(dioProvider)));

final userProvider = FutureProvider<UserModel>((ref) {
  return ref.read(dashboardDataSourceProvider).getUser();
});
