class ResponseJSON {
  String code;
  String message;
  String timestamp;
  bool status;
  dynamic data;
  ResponseJSON({
    required this.code,
    required this.message,
    required this.timestamp,
    required this.status,
    this.data,
  });
  ResponseJSON.fromJson(Map<String, dynamic> json)
      : code = json["responseCode"],
        message = json["responseMessage"],
        timestamp = json["responseTimestamp"],
        status = json["responseStatus"],
        data = json["data"];
}
