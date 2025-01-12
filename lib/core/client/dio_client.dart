import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:uas_flutter/core/client/dio_interceptor.dart';
import 'package:uas_flutter/core/client/exceptions.dart';
// import 'package:uas_flutter/utils/service/firebase/firebase_crash.dart';
import 'package:uas_flutter/domain/services/hive/hive.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:uas_flutter/main.dart';
import 'package:uas_flutter/view/login/login.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient with BoxMixin {
  String baseUrl = dotenv.env['BASE_URL'] as String;
  late Dio _dio;
  DioClient() {
    _dio = _createDio();
    _dio.interceptors.add(DioInterceptor());
  }
  Dio get dio {
    try {
      // _auth = getData(MainBoxKeys.token);
      // _contentType = getData(MainBoxKeys.contentType);
    } catch (_) {}

    final dio = _createDio();

    dio.interceptors.add(DioInterceptor());

    return dio;
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: '$baseUrl/',
          headers: {},
          receiveTimeout: const Duration(minutes: 1),
          connectTimeout: const Duration(minutes: 1),
          validateStatus: (int? status) {
            return true;
          },
        ),
      );

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    required Map<String, dynamic> queryParam,
    required ResponseConverter<T> converter,
    required Map<String, dynamic> headers,
  }) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParam,
        options: Options(headers: headers),
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 202) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return Right(converter(response.data));
    } on DioException catch (e) {
      // nonFatalError(error: e, stackTrace: stackTrace);
      if (e.response?.statusCode == 500 || e.response?.statusCode == 502) {
        return Left(
          ServerFailure(
            e.response?.statusCode,
            'Aplikasi sedang dalam gangguan',
          ),
        );
      }
      if (e.response?.statusCode == 400 || e.response?.statusCode == 502 || e.response?.data["responseMessage"]=="rpc error: code = Unknown desc = something went wrong") {
        // navigatorKey.currentState?.pushNamed(LoginApp.routeName);
        print("navigatorKey.currentContext");
        print(navigatorKey.currentContext);
        // navigatorKey.currentContext?.go(LoginApp.routeName);
        navigatorKey.currentContext?.goNamed(LoginApp.routeName);
        return Left(
          ServerFailure(
            e.response?.statusCode,
            'Aplikasi sedang dalam gangguan',
          ),
        );
      }
      if (e.response?.statusCode == 404) {
        return Left(
          ServerFailure(
            e.response?.statusCode,
            'Url tidak diketahui',
          ),
        );
      }
      if (e.response?.statusCode == 403) {
        return Left(
          ServerFailure(
            e.response?.statusCode,
            'Ciah gabisa masuk ya',
          ),
        );
      }
      return Left(
        ServerFailure(
          e.response?.statusCode,
          e.response?.data['responseMessage'] as String? ??
              e.response?.data['message'] as String?,
        ),
      );
    }
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    required Map<String, dynamic> data,
    required ResponseConverter<T> converter,
    required Map<String, dynamic> headers,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 202) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return Right(converter(response.data));
    } on DioException catch (e) {
      // nonFatalError(error: e, stackTrace: stackTrace);
      if (e.response?.statusCode == 500 || e.response?.statusCode == 502) {
        return Left(
          ServerFailure(
            e.response?.statusCode,
            'Aplikasi sedang dalam gangguan',
          ),
        );
      }
      if (e.response?.statusCode == 404) {
        return Left(
          ServerFailure(
            e.response?.statusCode,
            'Url tidak diketahui',
          ),
        );
      }
      if (e.response?.statusCode == 403) {
        return Left(
          ServerFailure(
            e.response?.statusCode,
            'Ciah gabisa masuk ya',
          ),
        );
      }
      return Left(
        ServerFailure(
          e.response?.statusCode,
          e.response?.data['responseMessage'] as String? ??
              e.response?.data['message'] as String?,
        ),
      );
    }
  }

  Future<Either<Failure, T>> postFormData<T>(
    String url, {
    required Map<String, dynamic> data,
    required ResponseConverter<T> converter,
    Map<String, dynamic>? headers,
    bool isIsolate = true,
  }) async {
    try {
      final header = headers ?? {};

      final FormData formData = FormData.fromMap({});
      await Future.forEach(
        data.entries,
        (MapEntry<String, dynamic> entry) async {
          final String key = entry.key;
          final String value = entry.value.toString();
          if (File(value).existsSync()) {
            formData.files.add(
              MapEntry(
                key,
                await MultipartFile.fromFile(
                  value,
                  filename: value.split('/').last,
                  contentType: MediaType('image', 'jpg'),
                ),
              ),
            );
          } else {
            formData.fields.add(MapEntry(key, value));
          }
        },
      );

      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: header),
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 202) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      return Right(converter(response.data));
    } on DioException catch (e) {
      // nonFatalError(error: e, stackTrace: stackTrace);
      if (e.response?.statusCode == 500 || e.response?.statusCode == 502) {
        return Left(
          ServerFailure(
            e.response?.statusCode,
            'Aplikasi sedang dalam gangguan',
          ),
        );
      }
      if (e.response?.statusCode == 404) {
        return Left(
          ServerFailure(
            e.response?.statusCode,
            'Url tidak diketahui',
          ),
        );
      }
      if (e.response?.statusCode == 403) {
        return Left(
          ServerFailure(
            e.response?.statusCode,
            'Ciah gabisa masuk ya',
          ),
        );
      }
      return Left(
        ServerFailure(
          e.response?.statusCode,
          e.response?.data['responseMessage'] as String? ??
              e.response?.data['message'] as String?,
        ),
      );
    }
  }
}
