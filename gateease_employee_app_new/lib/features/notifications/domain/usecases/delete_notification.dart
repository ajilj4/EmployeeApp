import '../repositories/notification_repository.dart';

class DeleteNotification {
  final NotificationRepository repository;

  DeleteNotification(this.repository);

  Future<void> call(int id) async {
    await repository.deleteNotification(id);
  }
}
