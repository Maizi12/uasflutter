import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaksi.freezed.dart';

/// Model representing a transaction in the application
@freezed
class Transaksis with _$Transaksis {
  const factory Transaksis({
    required String keteranganTransaksi,
    required int idUser,
    required int idTransaksi,
    required int idKategoriTransaksi,
    required int nominal,
    required String waktuTransaksi,
  }) = _Transaksis;

  /// Creates a Transaksis instance from a Firestore document
  factory Transaksis.fromDocument(DocumentSnapshot document) {
    return Transaksis(
      keteranganTransaksi: document['keteranganTransaksi'] as String? ?? '',
      idUser: document['idUser'] as int? ?? 0,
      idTransaksi: document['idTransaksi'] as int? ?? 0,
      idKategoriTransaksi: document['idKategoriTransaksi'] as int? ?? 0,
      nominal: document['nominal'] as int? ?? 0,
      waktuTransaksi: document['created_at']?.toString() ?? '',
    );
  }
}
