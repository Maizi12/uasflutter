class GetCoaModel {
  final int idCoa;
  final int idJenisCoa;
  final String kodeCoa;
  final String namaCoa;
  final int nominal;
  GetCoaModel({
    required this.idJenisCoa,
    required this.idCoa,
    required this.kodeCoa,
    required this.namaCoa,
    required this.nominal,
  });
  factory GetCoaModel.fromJson(Map<String, dynamic> json) {
    return GetCoaModel(
      idCoa: json["idCoa"],
      kodeCoa: json["kodeCoa"],
      namaCoa: json["namaCoa"],
      nominal: json["nominal"],
      idJenisCoa: json["idJenisCoa"],
    );
  }
}
