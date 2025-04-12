import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final Dio dio;

  NotificationRepositoryImpl({required this.dio});

  @override
  Future<List<Notification>> getNotifications() async {
    final Box<NotificationModel> notificationBox =
        await Hive.openBox<NotificationModel>('notifications');

    if (notificationBox.isNotEmpty) {
      return notificationBox.values.map((e) => e.toDomain()).toList();
    }

    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
      final List<dynamic> data = response.data;

      final List<NotificationModel> notifications =
          data.map((json) => NotificationModel.fromJson(json)).toList();

      await notificationBox.addAll(notifications);

      // Convert NotificationModel to Notification (Domain Entity)
      return notifications.map((e) => e.toDomain()).toList();
    } catch (e) {
      throw Exception('Failed to fetch notifications');
    }
  }

  @override
  Future<void> deleteNotification(int id) async {
    final Box<NotificationModel> notificationBox =
        await Hive.openBox<NotificationModel>('notifications');

    final key = notificationBox.keys.firstWhere(
      (k) => notificationBox.get(k)?.id == id,
      orElse: () => null,
    );

    if (key != null) {
      await notificationBox.delete(key);
    }
  }
}
