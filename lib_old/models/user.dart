import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// Model representing a user in the application
@freezed
class Users with _$Users {
  const factory Users({
    required String email,
    required String namaUser,
    required int id,
  }) = _Users;

  /// Creates a Users instance from a Firestore document
  factory Users.fromDocument(DocumentSnapshot document) {
    return Users(
      email: document['email'] as String? ?? '',
      namaUser: document['namaUser'] as String? ?? '',
      id: document['idUser'] as int? ?? 0,
    );
  }
}
