import 'package:dio/dio.dart';
import '../models/notification_model.dart';

class NotificationRemoteDataSource {
  final Dio dio;

  NotificationRemoteDataSource(this.dio);

  Future<List<NotificationModel>> getNotifications() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    return (response.data as List).map((e) => NotificationModel.fromJson(e)).toList();
  }
}
