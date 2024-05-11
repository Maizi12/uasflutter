import 'package:encrypt/encrypt.dart';

class EncryptionData {
  static const KEY = "CaLlo4iw1pYWELzxh7KoGg==";
  static const encryptionKeyGo = "iZiecbDb";
  // static const encryptionKey = "CaLlo4iw1pYWELzxh7KoGg";
  static const encryptionIV = "wKxDBe60kFxbPE1e";
  static const encryptionIV64 = "d0t4REJlNjBrRnhiUEUxZQ==";
  String encrypted = "";
  String decrypted = "";
  Encrypted encryptData(String plaintext, String key) {
    // Panjang kunci minimum 32 bytes (256 bit) untuk AES-256
    if (key.length < 32) {
      key = encryptionKeyGo + key; // Sesuaikan dengan kebutuhan Anda
    }
    print("key: $key");

    // Persiapkan plaintext
    // Uint8List plainTextBlock;
    // int length = plaintext.length;
    // print("length % 16 != 0: ${length % 16 != 0}");
    // if (length % 16 != 0) {
    //   int extendBlock = 16 - (length % 16);
    //   print("extendBlock");
    //   print(extendBlock);
    //   plainTextBlock = Uint8List(length + extendBlock);
    //   plainTextBlock.setRange(
    //       length, length + extendBlock, List.filled(extendBlock, extendBlock));
    // } else {
    //   plainTextBlock = Uint8List.fromList(utf8.encode(plaintext));
    // }
    // print("plainTextBlock $plainTextBlock");
    // // Enkripsi plaintext menggunakan AES
    // final keyBytes = Uint8List.fromList(utf8.encode(key));
    // final iv = Uint8List.fromList(
    //     utf8.encode('wKxDBe60kFxbPE1e')); // Sesuaikan dengan kebutuhan Anda
    // final keyParam = pointycastle.KeyParameter(keyBytes);
    // final params = pointycastle.ParametersWithIV(keyParam, iv);
    // final cipher = pointycastle.BlockCipher('AES/CBC');
    // // final Encrypter encrypter;

    // cipher.init(true, params);
    final Key keys;
    final Encrypter encrypter;

    keys = Key.fromUtf8(key);
    encrypter = Encrypter(
      AES(
        Key.fromUtf8(key),
        mode: AESMode.cbc,
      ),
    );
    // final encrypted = cipher.process(plainTextBlock);

    // Encode hasil enkripsi dalam bentuk base64
    // final encryptedBase64 = base64.encode(encrypted);

    // return encryptedBase64;
    final iv = IV.fromUtf8(encryptionIV);
    return encrypter.encrypt(plaintext, iv: iv);
  }

  String decryptData(String text, String encryptionKey) {
    final key = Key.fromUtf8(encryptionKey);

    final iv = IV.fromUtf8('wKxDBe60kFxbPE1e');

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: null));
    print(encrypter);
    print(Encrypted.fromBase64(text));
    final decrypted = encrypter.decrypt(Encrypted.from64(text), iv: iv);
    print("$text has been decrypted , and this is the value $decrypted");
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
