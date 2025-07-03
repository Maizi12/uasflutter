import 'package:uas_flutter/core/client/client.dart';
import 'package:uas_flutter/feature/data/model/general_response.dart';
import 'package:uas_flutter/feature/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class PostRequestUseCase {
  final Repository _repository;

  const PostRequestUseCase(this._repository);

  Future<Either<Failure, GeneralResponse>> call({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String> moreHeader = const {},
    required Map<String, dynamic> queryParam,
    bool isUseToken = true,
    ServiceBackend service = ServiceBackend.digituser,
  }) async {
    return _repository.postRequest(
      url: url,
      data: data,
      queryParameters: queryParam,
      moreHeader: moreHeader,
      isUseToken: isUseToken,
      service: service,
    );
  }
}
