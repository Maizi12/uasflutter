import 'dart:io';

import 'package:digit/core/client/dio_interceptor.dart';
import 'package:digit/core/client/exceptions.dart';
import 'package:digit/domain/services/hive/hive.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

/// HTTP client wrapper using Dio for API communication
class DioClient with BoxMixin {
  final Logger _logger = Logger();
  final String baseUrl = dotenv.env['BASE_URL'] as String;
  late Dio _dio;

  DioClient() {
    _dio = _createDio();
    _dio.interceptors.add(DioInterceptor());
  }

  /// Get the configured Dio instance
  Dio get dio {
    try {} catch (e) {
      _logger.w('Error getting auth data: $e');
    }

    final dio = _createDio();
    dio.interceptors.add(DioInterceptor());
    return dio;
  }

  /// Create a new Dio instance with base configuration
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

  /// Perform a GET request
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
      _logger.e('GET request failed: ${e.message}');
      return Left(_handleDioError(e));
    }
  }

  /// Perform a POST request
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
      _logger.e('POST request failed: ${e.message}');
      return Left(_handleDioError(e));
    }
  }

  /// Perform a POST request with form data
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
      _logger.e('POST form data request failed: ${e.message}');

      return Left(_handleDioError(e));
    }
  }

  Failure _handleDioError(DioException e) {
    if (e.response?.statusCode == 401) {
      // e.g., status code 401
      return UnauthenticatedFailure();
    }
    if (e.response?.statusCode == 400 ||
        e.response?.statusCode == 502 ||
        e.response?.data["responseMessage"] ==
            "rpc error: code = Unknown desc = something went wrong") {
      _logger.w('Authentication error, redirecting to login');
      return UnauthenticatedFailure();
    }

    if (e.response?.statusCode == 500 || e.response?.statusCode == 502) {
      return ServerFailure(
        e.response?.statusCode,
        'Aplikasi sedang dalam gangguan',
      );
    }
    if (e.response?.statusCode == 504) {
      return ServerFailure(
        e.response?.statusCode,
        'Time Out',
      );
    }

    if (e.response?.statusCode == 404) {
      return ServerFailure(
        e.response?.statusCode,
        'Url tidak diketahui',
      );
    }

    if (e.response?.statusCode == 403) {
      return ServerFailure(
        e.response?.statusCode,
        'Akses ditolak',
      );
    }

    if (e.response?.statusCode == 500 || e.response?.statusCode == 502) {
      return ServerFailure(
        e.response?.statusCode,
        'Aplikasi sedang dalam gangguan',
      );
    }

    return ServerFailure(
      e.response?.statusCode,
      e.response?.data['responseMessage'] as String? ??
          e.response?.data['message'] as String?,
    );
  }
}
