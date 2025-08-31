import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/models/new-tx-card.dart';
import 'package:uas_flutter/models/transaksi-go.dart';
import 'package:uas_flutter/pages/components/buttons.dart';
import 'package:uas_flutter/pages/components/header.dart';
import 'package:uas_flutter/pages/new-tx-card.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';
import 'package:uas_flutter/view/transaksi/transaksi2.dart';

class CreateMultiTransaksiApp extends StatefulWidget {
  const CreateMultiTransaksiApp({super.key});

  @override
  State<CreateMultiTransaksiApp> createState() => CreateMultiTransaksi();
}

class CreateMultiTransaksi extends State<CreateMultiTransaksiApp> {
  List<NewTxCard> data = [
    NewTxCard(
        idTx: 0,
        namaTransaksiBarang: "",
        tanggalTransaksi: "",
        akunDebit: "",
        akunKredit: "",
        idCoaDebit: 0,
        idCoaKredit: 0,
        qty: 0,
        hargaSatuan: 0,
        biayaTambahan: 0,
        nominalTransaksi: 0,
        debitKredit: "")
  ];

  TextEditingController namaTransaksiController = TextEditingController();
  TextEditingController namaCoaController = TextEditingController();

  int itemCounts = 1;
  double totalItem = 0;
  double totalTransaksi = 0;
  double biayaTambahan = 0;
  double totalTransaksiAll = 0;

  /// Helper function to recalculate totals
  void updateTotals() {
    setState(() {
      totalItem = data.fold(0, (sum, item) => sum + item.qty);
      totalTransaksi =
          data.fold(0, (sum, item) => sum + (item.hargaSatuan * item.qty));
      biayaTambahan = data.fold(0, (sum, item) => sum + item.biayaTambahan);
      totalTransaksiAll =
          data.fold(0, (sum, item) => sum + item.nominalTransaksi);
    });
  }

  /// Function to add a new transaction card
  void addNewTransaction() {
    setState(() {
      itemCounts++;
      data.add(NewTxCard(
          idTx: itemCounts,
          namaTransaksiBarang: "",
          tanggalTransaksi: "",
          akunDebit: "",
          akunKredit: "",
          idCoaDebit: 0,
          idCoaKredit: 0,
          qty: 0,
          hargaSatuan: 0,
          biayaTambahan: 0,
          nominalTransaksi: 0,
          debitKredit: ""));
    });
  }

  /// Function to remove a transaction card
  void removeTransaction(int index) {
    setState(() {
      data.removeAt(index);
      itemCounts--;
      updateTotals();
    });
  }

  String? error;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransaksiCubit, TransaksiState>(
      listener: (context, state) {
        state.whenOrNull(
          failed: (String? e) {
            setState(() {
              error = e;
            });
          },
        );
      },
      child: Scaffold(
        appBar: HeaderCard(namaMenu: "Buat Transaksi"),
        body: Column(
          children: [
            // Transaction List
            Expanded(
              child: Container(
                color: const Color(0xffF5F7FF),
                child: ListView.builder(
                  itemCount: itemCounts,
                  itemBuilder: (context, index) => CreateNewTxCardApp(
                    onremove: () => removeTransaction(index),
                    onupdate: () {
                      updateTotals();
                    },
                    data: data[index],
                  ),
                ),
              ),
            ),

            // Add Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: addNewTransaction,
                  child: const Icon(Icons.add_rounded,
                      color: Colors.blue, size: 50),
                ),
              ),
            ),

            // Summary Section
            SummaryNewTx(
              biayaTambahan: currencyFormatter.format((biayaTambahan)),
              totalItem: totalItem.toString(),
              totalTransaksi: currencyFormatter.format(totalTransaksi),
              totalTransaksiAll: currencyFormatter.format(totalTransaksiAll),
            ),

            // Submit Button
            ButtonTambah(
              ontap: () async {
                List<TransaksiGo> input = List.empty(growable: true);
                for (var i = 0; i < (data.length); i++) {
                  input.add(TransaksiGo(
                      idTransaksi: 0,
                      keteranganTransaksi: data[i].namaTransaksiBarang,
                      nominal: data[i].nominalTransaksi,
                      tglTransaksi: data[i].tanggalTransaksi,
                      idUser: 0,
                      idCoaDebit: data[i].idCoaDebit,
                      idCoaKredit: data[i].idCoaKredit));
                }
                var resultcreate =
                    await context.read<TransaksiCubit>().CreateTransaksi(input);
                // var resultcreate = await CreateTransaksi(input);
                resultcreate.fold((error) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: const Text("Gagal Tambahkan Transaksi"),
                          // content: Text("tokennya$token"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                );
                              },
                              child: const Text("Kembali"),
                            )
                          ]);
                    },
                  );
                }, (right) async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: const Text("Sukses Tambahkan Transaksi"),
                          // content: Text("tokennya$token"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            // WelcomeApp()
                                            Transaksi2App()));
                              },
                              child: const Text("Dashboard"),
                            )
                          ]);
                    },
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
