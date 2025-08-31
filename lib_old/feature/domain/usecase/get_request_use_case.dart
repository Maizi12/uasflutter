import 'package:uas_flutter/core/client/client.dart';
import 'package:uas_flutter/feature/data/model/general_response.dart';
import 'package:uas_flutter/feature/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class GetRequestUseCase {
  final Repository _repository;

  const GetRequestUseCase(this._repository);

  Future<Either<Failure, GeneralResponse>> call({
    required String url,
    Map<String, dynamic> queryParam = const {},
    Map<String, String> moreHeader = const {},
    bool isUseToken = true,
    ServiceBackend service = ServiceBackend.digituser,
  }) async {
    return _repository.getRequest(
      url: url,
      queryParam: queryParam,
      moreHeader: moreHeader,
      isUseToken: isUseToken,
      service: service,
    );
  }
}
