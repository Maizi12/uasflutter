import 'package:digit/core/client/client.dart';
import 'package:digit/data/models/general_response.dart';
import 'package:digit/core/utils/helper/signature.dart';
import 'package:digit/domain/services/hive/hive.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, GeneralResponse>> getRequest({
    required String url,
    required Map<String, dynamic> queryParam,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
  });

  Future<Either<Failure, GeneralResponse>> postRequest({
    required String url,
    required Map<String, dynamic> queryParam,
    required Map<String, dynamic> data,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
  });
  Future<Either<Failure, GeneralResponse>> postFormData({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
  });
}

class RemoteDataSourceImpl with BoxMixin implements RemoteDataSource {
  final DioClient _client;
  RemoteDataSourceImpl(this._client);

  @override
  Future<Either<Failure, GeneralResponse>> getRequest({
    required String url,
    required Map<String, dynamic> queryParam,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
  }) async {
    Map<String, String> header = {};
    String basicAuth = '';
    // String signature = '';
    // final urlFull = '${dotenv.env['BASE_URL']}/$url';
    // final timestamp = Signature().getTimestamp();
    // final payload = {
    //   'get': urlFull,
    //   // 'timestamp': timestamp,
    // };

    if (service == ServiceBackend.digituser) {
      // signature = Signature().getSignature(
      //   dotenv.env['API_KEY_BORROWERUSER'].toString(),
      //   payload,
      // );
      basicAuth = Signature().getBasicAuth(
        dotenv.env['UNAMEBORROWERUSER'].toString(),
        dotenv.env['PWBORROWERUSER'].toString(),
      );
      header = {
        'api-key': dotenv.env['API_KEY_BORROWERUSER'].toString(),
        // 'x-SIGNATURE-key': signature,
        // 'timestamps': timestamp,
      };
    }

    if (isUseToken) {
      final token = await getData(KeyStorage.accessToken);
      header['Authorization'] = 'Bearer $token';
    } else {
      header['Authorization'] = basicAuth;
    }
    final headers = {
      ...header,
      ...moreHeader,
    };
    final response = _client.getRequest(
      url,
      queryParam: queryParam,
      converter: (response) => GeneralResponse.fromJson(response),
      headers: headers,
    );
    return response;
  }

  @override
  Future<Either<Failure, GeneralResponse>> postRequest({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, dynamic> queryParam,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
  }) async {
    Map<String, String> header = {};
    String basicAuth = '';
    String signature = '';
    final payload = {
      'request': data,
    };

    if (service == ServiceBackend.digituser) {
      basicAuth = Signature().getBasicAuth(
        dotenv.env['UNAMEBORROWERUSER'].toString(),
        dotenv.env['PWBORROWERUSER'].toString(),
      );
      header = {
        'api-key': dotenv.env['API_KEY_BORROWERUSER'].toString(),
        'x-SIGNATURE-key': signature,
      };
    }

    if (isUseToken) {
      final token = await getData(KeyStorage.accessToken);
      header['Authorization'] = 'Bearer $token';
    } else {
      header['Authorization'] = basicAuth;
    }
    final headers = {
      ...header,
      ...moreHeader,
    };
    final response = _client.postRequest(
      url,
      data: payload,
      converter: (response) => GeneralResponse.fromJson(response),
      headers: headers,
    );
    return response;
  }

  @override
  Future<Either<Failure, GeneralResponse>> postFormData({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
  }) async {
    Map<String, String> header = {};
    String basicAuth = '';
    String signature = '';

    if (service == ServiceBackend.digituser) {
      basicAuth = Signature().getBasicAuth(
        dotenv.env['UNAMEBORROWERUSER'].toString(),
        dotenv.env['PWBORROWERUSER'].toString(),
      );
      header = {
        'api-key': dotenv.env['API_KEY_BORROWERUSER'].toString(),
        'x-SIGNATURE-key': signature,
      };
    }

    if (isUseToken) {
      final token = await getData(KeyStorage.accessToken);
      header['Authorization'] = 'Bearer $token';
    } else {
      header['Authorization'] = basicAuth;
    }
    final headers = {
      ...header,
      ...moreHeader,
    };
    final response = _client.postFormData(
      url,
      data: data,
      converter: (response) => GeneralResponse.fromJson(response),
      headers: headers,
    );
    return response;
  }
}
