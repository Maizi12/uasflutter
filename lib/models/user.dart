import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String email;
  final String namaUser;
  final int id;

  const Users({
    required this.email,
    required this.namaUser,
    required this.id,
  });

  factory Users.fromDocument(DocumentSnapshot document) {
    return Users(
      email: document['email'],
      namaUser: document['namaUser'],
      id: document['idUser'],
    );
  }
}
