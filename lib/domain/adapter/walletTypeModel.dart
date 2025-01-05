import 'package:hive/hive.dart';

// Annotate your class with HiveType and its fields with HiveField
@HiveType(typeId: 0)
class GetWalletModel extends HiveObject {
  @HiveField(0)
  final String walletName;

  @HiveField(1)
  final double balance;

  GetWalletModel({required this.walletName, required this.balance});
}

// Create a TypeAdapter for GetWalletModel
class GetWalletModelAdapter extends TypeAdapter<GetWalletModel> {
  @override
  final int typeId = 0;

  @override
  GetWalletModel read(BinaryReader reader) {
    return GetWalletModel(
      
      walletName: reader.readString(),
      balance: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, GetWalletModel obj) {
    writer.writeString(obj.walletName);
    writer.writeDouble(obj.balance);
  }
}
