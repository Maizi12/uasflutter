import 'package:digit/core/core.dart';
import 'package:digit/data/datasources/auth_local_datasource.dart';
import 'package:digit/data/datasources/auth_remote_datasource.dart';
import 'package:digit/data/datasources/remotedata_source.dart';
import 'package:digit/domain/repositories/auth_repository_impl.dart';
import 'package:digit/domain/repositories/transaksi_repository_impl.dart';
import 'package:digit/domain/repository/auth_repository.dart';
import 'package:digit/domain/repository/transaksi_repository.dart';
import 'package:digit/domain/repository/repository.dart';
import 'package:digit/domain/repository/repository_impl.dart';
import 'package:digit/domain/usecases/get_request_use_case.dart';
import 'package:digit/domain/usecases/post_form_data_use_case.dart';
import 'package:digit/domain/usecases/post_request_use_case.dart';
import 'package:digit/domain/services/hive/hive.dart';
import 'package:digit/presentation/cubits/auth/auth_cubit.dart';
import 'package:digit/presentation/cubits/transaksi/transaksi_cubit.dart';
import 'package:digit/providers/navigation_history_provider.dart';
import 'package:get_it/get_it.dart';

/// Global GetIt instance for dependency injection
GetIt sl = GetIt.instance;

/// Initialize the service locator with all dependencies
Future<void> serviceLocator({
  bool isUnitTest = false,
  bool isHiveEnable = true,
  String prefixBox = '',
}) async {
  if (isUnitTest) {
    await sl.reset();
  }

  // Register core services
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerLazySingleton<NavigationHistory>(() => NavigationHistory());
  // Register data sources, repositories, use cases, and cubits
  dataSource();
  repositories();
  useCase();
  cubit();

  // Initialize Hive boxes if enabled
  if (isHiveEnable) {
    await _initHiveBoxes(prefixBox: prefixBox);
  }
}

/// Initialize Hive boxes for local storage
Future<void> _initHiveBoxes({
  String prefixBox = '',
}) async {
  await BoxMixin.initHive(prefixBox);
  sl.registerSingleton<BoxMixin>(BoxMixin());
}

/// Register repository implementations
void repositories() {
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
        sl<AuthRemoteDataSource>(), sl<AuthLocalDataSource>()),
  );
  sl.registerLazySingleton<TransaksiRepository>(
    () => TransaksiRepositoryImpl(sl(), sl()),
  );
}

/// Register data source implementations
void dataSource() {
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl(), sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
}

/// Register use case implementations
void useCase() {
  sl.registerLazySingleton(() => GetRequestUseCase(sl()));
  sl.registerLazySingleton(() => PostRequestUseCase(sl()));
  sl.registerLazySingleton(() => PostFormDataUseCase(sl()));
}

/// Register Cubit implementations
void cubit() {
  sl.registerFactory(
    () => AuthCubit(sl<AuthRepository>()),
  );
  sl.registerFactory(
    () => TransaksiCubit(sl<TransaksiRepository>()),
  );
}
