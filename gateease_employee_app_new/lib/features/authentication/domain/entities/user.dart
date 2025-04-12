import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String token;
  final String email;
  final String name;

  const User({
    required this.token,
    required this.email,
    required this.name,
  });

  @override
  List<Object?> get props => [token, email, name];
}
