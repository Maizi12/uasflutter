import 'package:cloud_firestore/cloud_firestore.dart';

class Wallets {
  int idUser;
  int idWallet;
  String namaWallet;

  Wallets({
    required this.idUser,
    required this.idWallet,
    required this.namaWallet,
  });

  factory Wallets.fromDocument(DocumentSnapshot document) {
    return Wallets(
        namaWallet: document['namaWallet'],
        idUser: document['idUser'],
        idWallet: document['idWallet']);
  }
}
