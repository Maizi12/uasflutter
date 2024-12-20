import 'package:uas_flutter/core/core.dart';
import 'package:uas_flutter/feature/feature.dart';
import 'package:uas_flutter/domain/services/hive/hive.dart';
import 'package:uas_flutter/view/login/cubit/auth_cubit.dart';
// import 'package:uas_flutter/view/transaksi/cubit/beranda_cubit.dart';
// import 'package:uas_flutter/view/regis/cubit/register_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({
  bool isUnitTest = false,
  bool isHiveEnable = true,
  String prefixBox = '',
}) async {
  if (isUnitTest) {
    await sl.reset();
  }
  sl.registerSingleton<DioClient>(DioClient());
  dataSource();
  repositories();
  useCase();
  cubit();
  await _initHiveBoxes();
}

Future<void> _initHiveBoxes({
  String prefixBox = '',
}) async {
  await BoxMixin.initHive(prefixBox);
  sl.registerSingleton<BoxMixin>(BoxMixin());
}

void repositories() {
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(sl(), sl()),
  );
}

void dataSource() {
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(sl()),
  );
}

void useCase() {
  sl.registerLazySingleton(() => GetRequestUseCase(sl()));
  sl.registerLazySingleton(() => PostRequestUseCase(sl()));
  sl.registerLazySingleton(() => PostFormDataUseCase(sl()));
}

void cubit() {
  sl.registerFactory(() => AuthCubit(sl()));
  // sl.registerFactory(() => LoginCu());
  // sl.registerFactory(() => RegisterCubit());
}
