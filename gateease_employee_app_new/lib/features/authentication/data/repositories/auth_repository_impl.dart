// features/authentication/data/repositories/auth_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      
      // Save user data to Hive
      final box = await Hive.openBox('auth');
      await box.put('token', userModel.token);
      await box.put('user', {
        '_id': userModel.id,
        'name': userModel.name,
        'email': userModel.email,
        'token': userModel.token,
      });
      
      return Right(userModel);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      print("Repository error: $e");
      return Left(ServerFailure("Login failed. Please try again."));
    }
  }
  
  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      // Clear all stored authentication data
      final box = await Hive.openBox('auth');
      await box.clear(); // This removes all keys in the box
      
      return const Right(true);
    } catch (e) {
      print("Logout error: $e");
      return Left(ServerFailure("Logout failed. Please try again."));
    }
  }
}