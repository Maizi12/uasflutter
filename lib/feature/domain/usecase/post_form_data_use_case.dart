import 'package:uas_flutter/core/client/client.dart';
import 'package:uas_flutter/feature/data/model/general_response.dart';
import 'package:uas_flutter/feature/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class PostFormDataUseCase {
  final Repository _repository;

  const PostFormDataUseCase(this._repository);

  Future<Either<Failure, GeneralResponse>> call({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String> moreHeader = const {},
    bool isUseToken = true,
    ServiceBackend service = ServiceBackend.digituser,
  }) async {
    return _repository.postFormData(
      url: url,
      data: data,
      moreHeader: moreHeader,
      isUseToken: isUseToken,
      service: service,
    );
  }
}
