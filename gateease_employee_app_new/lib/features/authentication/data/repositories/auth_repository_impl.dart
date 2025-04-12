import 'package:dartz/dartz.dart';
import 'package:gateease_employee_app_new/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/entities/user.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/repositories/auth_repository.dart';
import 'package:gateease_employee_app_new/core/errors/failure.dart';
import 'package:hive/hive.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);

      final box = await Hive.openBox('auth');
      await box.put('token', user.token);
      await box.put('user', {'email': user.email, 'name': user.name});

      return Right(user); // ✅ Return user on success
    } catch (error) {
      return Left(ServerFailure(error.toString())); // ✅ Return Failure on error
    }
  }

 
}
