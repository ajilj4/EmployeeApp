import 'package:dartz/dartz.dart';
import 'package:gateease_employee_app_new/core/errors/failure.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/entities/user.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
