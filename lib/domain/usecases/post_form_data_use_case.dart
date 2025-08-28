import 'package:digit/core/client/client.dart';
import 'package:digit/data/models/general_response.dart';
import 'package:digit/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class PostFormDataUseCase {
  final Repository _repository;

  const PostFormDataUseCase(this._repository);

  Future<Either<Failure, GeneralResponse>> call({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, dynamic> queryParam,
    Map<String, String> moreHeader = const {},
    bool isUseToken = true,
    ServiceBackend service = ServiceBackend.digituser,
  }) async {
    return _repository.postFormData(
      url: url,
      data: data,
      queryParam: queryParam,
      moreHeader: moreHeader,
      isUseToken: isUseToken,
      service: service,
    );
  }
}
