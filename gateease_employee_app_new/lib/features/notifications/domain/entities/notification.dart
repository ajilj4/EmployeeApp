import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final int id;
  final String title;
  final String body;

  const Notification({required this.id, required this.title, required this.body});

  @override
  List<Object?> get props => [id, title, body];
}
