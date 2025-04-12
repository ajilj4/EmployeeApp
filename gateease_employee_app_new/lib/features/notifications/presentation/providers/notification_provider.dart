import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/delete_notification.dart';
import '../../data/repositories/notification_repository_impl.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final notificationRepositoryProvider = Provider<NotificationRepositoryImpl>(
  (ref) => NotificationRepositoryImpl(dio: ref.watch(dioProvider)),
);

final getNotificationsProvider = Provider<GetNotifications>(
  (ref) => GetNotifications(ref.watch(notificationRepositoryProvider)),
);

final deleteNotificationProvider = Provider<DeleteNotification>(
  (ref) => DeleteNotification(ref.watch(notificationRepositoryProvider)),
);

class NotificationsNotifier extends StateNotifier<List<Notification>> {
  final GetNotifications getNotifications;
  final DeleteNotification deleteNotification;

  NotificationsNotifier({required this.getNotifications, required this.deleteNotification}) : super([]) {
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final notifications = await getNotifications();
    state = notifications;
  }

  Future<void> removeNotification(int id) async {
    await deleteNotification(id);
    state = state.where((notification) => notification.id != id).toList();
  }
}

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, List<Notification>>((ref) {
  return NotificationsNotifier(
    getNotifications: ref.watch(getNotificationsProvider),
    deleteNotification: ref.watch(deleteNotificationProvider),
  );
});
