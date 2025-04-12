import 'package:equatable/equatable.dart';

/// Abstract class for all types of failures
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// 🔹 Failure for API Errors (e.g., Server Down, Invalid Credentials)
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

/// 🔹 Failure for Network Issues (e.g., No Internet)
class NetworkFailure extends Failure {
  const NetworkFailure() : super("No internet connection. Please try again.");
}

/// 🔹 Failure for Cache Issues (e.g., Data Storage Failure)
class CacheFailure extends Failure {
  const CacheFailure() : super("Failed to fetch local data.");
}
