import 'package:dartz/dartz.dart';
import 'package:gateease_employee_app_new/core/errors/failure.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
}
