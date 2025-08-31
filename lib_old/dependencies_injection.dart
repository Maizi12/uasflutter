import 'package:uas_flutter/core/core.dart';
import 'package:uas_flutter/feature/feature.dart';
import 'package:uas_flutter/domain/services/hive/hive.dart';
import 'package:uas_flutter/view/login/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

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
}

/// Register data source implementations
void dataSource() {
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(sl()),
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
    () => AuthCubit(sl<PostRequestUseCase>(), sl<GetRequestUseCase>()),
  );
  sl.registerFactory(
    () => TransaksiCubit(sl<GetRequestUseCase>(), sl<PostRequestUseCase>()),
  );
}
