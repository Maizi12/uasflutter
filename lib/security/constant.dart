import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'dart:typed_data';
import 'package:pointycastle/export.dart' as pointycastle;
import 'package:crypto/crypto.dart' as crypto;

class EncryptionData {
  static const KEY = "CaLlo4iw1pYWELzxh7KoGg==";
  static const encryptionKeyGo = "iZiecbDb";
  // static const encryptionKey = "CaLlo4iw1pYWELzxh7KoGg";
  static const encryptionIV = "wKxDBe60kFxbPE1e";
  static const encryptionIV64 = "d0t4REJlNjBrRnhiUEUxZQ==";
  String encrypted = "";
  String decrypted = "";
  String encryptData(String plaintext, String key) {
    // Panjang kunci minimum 32 bytes (256 bit) untuk AES-256
    if (key.length < 32) {
      key = key + encryptionKeyGo; // Sesuaikan dengan kebutuhan Anda
    }
    print("key: $key");

    // Persiapkan plaintext
    Uint8List plainTextBlock;
    int length = plaintext.length;
    print("length % 16 != 0: ${length % 16 != 0}");
    if (length % 16 != 0) {
      int extendBlock = 16 - (length % 16);
      plainTextBlock = Uint8List(length + extendBlock);
      plainTextBlock.setRange(
          length, length + extendBlock, List.filled(extendBlock, extendBlock));
    } else {
      plainTextBlock = Uint8List.fromList(utf8.encode(plaintext));
    }

    // Enkripsi plaintext menggunakan AES
    final keyBytes = Uint8List.fromList(utf8.encode(key));
    final iv = Uint8List.fromList(
        utf8.encode('YOUR_IV_KEY')); // Sesuaikan dengan kebutuhan Anda
    final keyParam = pointycastle.KeyParameter(keyBytes);
    final params = pointycastle.ParametersWithIV(keyParam, iv);
    final cipher =
        pointycastle.BlockCipher('AES/CBC') as pointycastle.BlockCipher;
    cipher.init(true, params);

    final encrypted = cipher.process(plainTextBlock);

    // Encode hasil enkripsi dalam bentuk base64
    final encryptedBase64 = base64.encode(encrypted);

    return encryptedBase64;
  }

  String decryptData(String text, String encryptionKey) {
    final key = Key.fromUtf8(encryptionKey);

    final iv = IV.fromUtf8(encryptionIV);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: "PKCS7"));
    print(Encrypted.fromUtf8(text).bytes);
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(text), iv: iv);
    print("$text has been encrypted , and this is the value ${decrypted}");
    return decrypted;
  }
}

class EncryptionModes {
  static const CBC = "AESMode.cbc";

  static const CFB64 = "AESMode.cfb64";

  static const CTR = "AESMode.ctr";

  static const ECB = "AESMode.ecb";

  static const OFB64GCTR = "AESMode.ofb64Gctr";

  static const OFB64 = "AESMode.ofb64";

  static const SIC = "AESMode.sic";

  static const PADDING = "PKCS7";

  static const ENCRYPTION_KEY_GO = "iZiecbDb";
  static const ENCRYPTION_IV = "wKxDBe60kFxbPE1e";

  static const AESPADDING = "PKCS7";
  String get sic => PADDING;

  String get encryptionKeyGo => ENCRYPTION_KEY_GO;

  String get encryptionIV => ENCRYPTION_IV;
}
