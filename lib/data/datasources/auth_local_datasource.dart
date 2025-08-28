// data/datasources/auth_local_datasource.dart  
import 'package:digit/domain/services/hive/hive.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthLocalDataSourceImpl with BoxMixin  implements AuthLocalDataSource {
  
  AuthLocalDataSourceImpl();

  @override
  Future<void> saveToken(String token) async {
    await BoxMixin().addData(KeyStorage.accessToken,token);
  }

  @override
  Future<String?> getToken() async {
    return await BoxMixin().getData(KeyStorage.accessToken);
  }

  @override
  Future<void> clearToken() async {
    await BoxMixin().removeData(KeyStorage.accessToken);
  }
}