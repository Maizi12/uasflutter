import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_flutter/domain/services/hive/hive.dart';
import 'package:uas_flutter/helper/logger.dart';
// import 'package:uas_flutter/utils/service/firebase/firebase_crash.dart';
import 'package:dio/dio.dart';
import 'package:uas_flutter/main.dart';
import 'package:uas_flutter/view/login/login.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String headerMessage = "";
    options.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    try {} catch (_) {}
    try {
      final String prettyJson = _getDataAsString(options.data);
      // final params = _queryParamBuilder(options.queryParameters);
      log.d(
        // ignore: unnecessary_null_comparison
        "REQUEST ► ︎ ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"${options.baseUrl}${options.path}"}\n"
        "Headers:\n"
        "$headerMessage\n"
        "❖ QueryParameters :\n${_buildQueryParametersString(options.queryParameters)}\n"
        "Body: $prettyJson",
      );
    } catch (e) {
      log.e("Failed to extract json request $e");
      // nonFatalError(error: e, stackTrace: stackTrace);
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException dioException, ErrorInterceptorHandler handler) {
    log.e(
      "<-- ${dioException.message} ${dioException.response?.requestOptions != null ? (dioException.response!.requestOptions.baseUrl + dioException.response!.requestOptions.path) : 'URL'}\n\n"
      "${dioException.response != null ? dioException.response!.data : 'Unknown Error'}",
    );

    // nonFatalError(error: dioException, stackTrace: dioException.stackTrace);
    super.onError(dioException, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String headerMessage = "";
    response.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(response.data);
    log.d(
      // ignore: unnecessary_null_comparison
      "◀ ︎RESPONSES ${response.statusCode} ${response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL'}\n\n"
      "Headers:\n"
      "$headerMessage\n"
      "❖ Results : \n"
      "Responses: $prettyJson",
    );

    if (response.statusCode == 401 ||
        response.data["responseMessage"] ==
            "rpc error: code = Unknown desc = something went wrong") {
      // Token expired, redirect to login page
      if (navigatorKey.currentContext != null) {
        BoxMixin().removeData(KeyStorage.accessToken);
        navigatorKey.currentContext?.go(LoginApp.routeName);
        // navigatorKey.currentContext?.push('/login_page');
        navigatorKey.currentState?.push<void>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const LoginApp(),
          ),
        );
        // navigatorKey.currentState?.pushNamed(LoginApp.routeName);
      }
    }
    super.onResponse(response, handler);
  }

  String _getDataAsString(dynamic data) {
    if (data is FormData) {
      // Handle FormData differently
      final fields = data.fields
          .map((entry) => '► ${entry.key}: ${entry.value}')
          .join('\n');
      final files = data.files
          .map((entry) => '► ${entry.key}: ${entry.value}')
          .join('\n');
      return '\n► Fields: \n$fields\n► Files: $files\n';
    } else {
      // Convert other types to JSON
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    }
  }

  String _buildQueryParametersString(Map<String, dynamic> queryParameters) {
    if (queryParameters.isEmpty) {
      return 'No query parameters';
    } else {
      return queryParameters.entries
          .map((entry) => '► ${entry.key}: ${entry.value}')
          .join('\n');
    }
  }

  String _queryParamBuilder(Map<String, dynamic> params) {
    String param = '?';
    params.forEach((key, value) {
      if (value is List) {
        for (var element in value) {
          param += '$key=${Uri.encodeQueryComponent(element.toString())}&';
        }
      } else {
        param += '$key=${Uri.encodeQueryComponent(value.toString())}&';
      }
    });
    print('paramnya nih: $param');
    return param;
  }
}
