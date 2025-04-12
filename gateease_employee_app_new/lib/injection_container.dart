import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'features/authentication/domain/usecases/login_usecase.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/data/datasources/auth_remote_data_source.dart';

final GetIt sl = GetIt.instance;

void init() {
  // Register external dependencies
  sl.registerLazySingleton(() => Dio()); // Register Dio instance
  
  // Register Data Source with Dio parameter
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<Dio>()),
  );
  
  // Register Repository with the required parameter
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );
  
  // Register Use Case with the required repository
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
}