class Token {
  String key;
  String now;
  Token({
    required this.key,
    required this.now,
  });

  Token.fromJson(Map<String, dynamic> json)
      : key = json["key"],
        now = json["timestamppass"];
}
