abstract class DTO {
  static Map<String, dynamic> enkrip({
    required String ResponseCode,
    required String ResponseMessage,
    required dynamic Data,
  }) {
    return {
      "responseCode": ResponseCode,
      "responseMessage": ResponseMessage,
      "data": Data
    };
  }
}
