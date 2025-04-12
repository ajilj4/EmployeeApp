import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/notification.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final int id;
  final String title;
  final String body;

  const NotificationModel({required this.id, required this.title, required this.body});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  // Convert NotificationModel to Notification (Domain Entity)
  Notification toDomain() => Notification(id: id, title: title, body: body);
}
