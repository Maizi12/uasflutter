import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uas_flutter/constant/appconstants.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/models/new-tx-card.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/components/buttons.dart';
import 'package:uas_flutter/pages/components/dropdown-coa.dart';
import 'package:uas_flutter/pages/components/dropdown-wallet.dart';
import 'package:uas_flutter/pages/components/select-date.dart';
import 'package:uas_flutter/pages/styles/textstyle.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';
import 'package:uas_flutter/util/data-fetch/getcoa-helper.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

class CreateNewTxCardApp extends StatefulWidget {
  const CreateNewTxCardApp({
    super.key,
    required this.onremove,
    required this.onupdate,
    required this.data,
  });
  final VoidCallback? onremove;
  final VoidCallback? onupdate;
  final NewTxCard data;
  // List<GetCoaModel>? listWallet;
  // GetCoaModel? selectedwallet;
  // String? dropdownWalletValue;
  // List<GetJenisTransaksiModel>? listJenisTransaksi;
  // GetJenisTransaksiModel? selectedjenisTransaksi;
  // final String? restorationId;
  // String tanggal = "";
  // String? dropdownJenisTransaksiValue;
  // final RestorableDateTime _selectedDate = RestorableDateTime(
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  @override
  State<CreateNewTxCardApp> createState() => CreateNewTxCard();
}

final currencyFormatter =
    NumberFormat.currency(locale: "id_ID", symbol: "Rp ", decimalDigits: 2);

String getRawNumber(String formattedText) {
  formattedText = formattedText
      .replaceAll(",00", "")
      .replaceAll(".", "")
      .replaceAll(".", "")
      .replaceAll(",", ".");
  return formattedText.replaceAll(RegExp(r'[^0-9.]'), '');
}

class CreateNewTxCard extends State<CreateNewTxCardApp> {
  @override
  void initState() {
    super.initState();
    GetCoa();
    qtyController.text = "";
    hargaSatuanController.text = "";
    biayaTambahanController.text = "";
    nominalTransaksiController.text = "";

    var month = selectedDate.month < 10
        ? "0${selectedDate.month}"
        : selectedDate.month.toString();
    var day = selectedDate.day < 10
        ? "0${selectedDate.day}"
        : selectedDate.day.toString();
    widget.data.tanggalTransaksi = '${selectedDate.year}-$month-$day';
  }

  TextEditingController namaTransaksiController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController hargaSatuanController = TextEditingController();
  TextEditingController biayaTambahanController = TextEditingController();
  TextEditingController nominalTransaksiController = TextEditingController();
  String tanggal = "";
  final DateTime now = DateTime.now();
  GetCoaModel selectedlistDebit = GetCoaModel(
      namaCoa: "Create Coa", idCoa: 0, nominal: 0, kodeCoa: "", idJenisCoa: 0);
  List<GetCoaModel> listDebit = [
    GetCoaModel(
        idCoa: 0, namaCoa: "Create Coa", nominal: 0, kodeCoa: "", idJenisCoa: 0)
  ];
  GetCoaModel selectedlistKredit = GetCoaModel(
      namaCoa: "Create Coa", idCoa: 0, nominal: 0, kodeCoa: "", idJenisCoa: 0);
  List<GetCoaModel> listKredit = [
    GetCoaModel(
        idCoa: 0, namaCoa: "Create Coa", nominal: 0, kodeCoa: "", idJenisCoa: 0)
  ];
  String tgl = DateFormat.yMMMMd("id_ID").format(DateTime.now());
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  GetCoa() async {
    final listcoa = await FetchCoa(context, 0);

    setState(() {
      listDebit = listcoa;
      listKredit = listcoa;
      var emptyCoa = GetCoaModel(
          namaCoa: "Create Coa",
          idCoa: 0,
          idJenisCoa: 0,
          kodeCoa: "",
          nominal: 0);
      listDebit.add(emptyCoa);
      listKredit.add(emptyCoa);
    });
  }

  UpdateNominalTransaksi() async {
    double hargaSatuan =
        double.tryParse(getRawNumber(hargaSatuanController.text)) ?? 0;
    int qty = int.tryParse(qtyController.text) ?? 0;
    double biayaTambahan =
        double.tryParse(getRawNumber(biayaTambahanController.text)) ?? 0;
    double totalNominal = (hargaSatuan * qty) + biayaTambahan;
    nominalTransaksiController.text = currencyFormatter.format(totalNominal);

    // Store raw value in data model
    widget.data.nominalTransaksi = totalNominal;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransaksiCubit, TransaksiState>(
        listener: (context, state) {
          state.whenOrNull(
            failed: (String? e) {},
          );
        },
        child: Container(
            width: 375,
            height: 310,
            color: Colors.white,
            child: Column(
              children: [
                Row(children: [
                  Container(
                    width: 20,
                  ),
                  SizedBox(
                    width: 118,
                    height: 16,
                    child: AutoSizeText(
                      "Nama Transaksi/Barang",
                      minFontSize: 10,
                      maxFontSize: 12,
                      style: CustomTextStyle.StyleList(),
                    ),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  SizedBox(
                    width: 184,
                    height: 16,
                    child: TextField(
                      controller: namaTransaksiController,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan Nama Transaksi",
                          hintStyle: CustomTextStyle.StyleList()),
                      style: CustomTextStyle.StyleList(),
                      onChanged: (value) {
                        widget.onupdate?.call();
                        widget.data.namaTransaksiBarang =
                            namaTransaksiController.text;
                      },
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),
                SelectDateApp(
                  onDateSelected: (DateTime date) {
                    setState(() {
                      selectedDate = date;
                      var month = date.month < 10
                          ? "0${date.month}"
                          : date.month.toString();
                      var day =
                          date.day < 10 ? "0${date.day}" : date.day.toString();
                      widget.data.tanggalTransaksi =
                          '${date.year}-$month-$day';
                      widget.onupdate?.call();
                    });
                  },
                  tgl: (String tgls) {
                    tgl = tgls;
                  },
                  child: SelectDateMultiTx(
                    selectedDate: tgl,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(children: [
                  Container(
                    width: 20,
                  ),
                  SizedBox(
                    width: 118,
                    height: 16,
                    child: AutoSizeText(
                      "Debit",
                      minFontSize: 10,
                      maxFontSize: 12,
                      style: CustomTextStyle.StyleList(),
                    ),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  SizedBox(
                    width: 184,
                    height: 16,
                    child: DropdownCoaApp(
                      selectedcoa: selectedlistDebit,
                      selectCoa: (GetCoaModel select) {
                        widget.data.idCoaDebit = select.idCoa;
                        widget.data.akunDebit = select.namaCoa;
                        // context.read<TransaksiCubit>().selectWallet(select);
                        selectedlistDebit = select;
                        if (select.kodeCoa[0] == "5") {
                          widget.data.debitKredit = "K";
                        }
                      },
                      icon: Visibility(
                        child: Icon(Icons.arrow_downward),
                        visible: false,
                      ),
                      onupdate: () {
                        widget.onupdate?.call();
                      },
                      ListCoa: listDebit,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),
                Row(children: [
                  Container(
                    width: 20,
                  ),
                  SizedBox(
                    width: 118,
                    height: 16,
                    child: AutoSizeText(
                      "Kredit",
                      minFontSize: 10,
                      maxFontSize: 12,
                      style: CustomTextStyle.StyleList(),
                    ),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  SizedBox(
                      width: 184,
                      height: 16,
                      child: DropdownCoaApp(
                        selectedcoa: selectedlistKredit,
                        selectCoa: (GetCoaModel select) {
                          widget.data.idCoaKredit = select.idCoa;
                          widget.data.akunKredit = select.namaCoa;
                          // context.read<TransaksiCubit>().selectWallet(select);
                          selectedlistKredit = select;
                          if (select.kodeCoa[0] == "1") {
                            widget.data.debitKredit = "D";
                          }
                        },
                        icon: Visibility(
                          child: Icon(Icons.arrow_downward),
                          visible: false,
                        ),
                        onupdate: () {
                          // widget.onupdate?.call();
                        },
                        ListCoa: listKredit,
                      )),
                ]),
                const SizedBox(
                  height: 16,
                ),
                Row(children: [
                  Container(
                    width: 20,
                  ),
                  SizedBox(
                    width: 118,
                    height: 16,
                    child: AutoSizeText(
                      "Qty",
                      minFontSize: 10,
                      maxFontSize: 12,
                      style: CustomTextStyle.StyleList(),
                    ),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  SizedBox(
                    width: 184,
                    height: 16,
                    child: TextField(
                      controller: qtyController,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.end,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintStyle: CustomTextStyle.StyleList(),
                      ),
                      // style: CustomTextStyle.StyleList(),
                      onChanged: (value) {
                        setState(() {
                          widget.data.qty = int.parse(qtyController.text);
                          UpdateNominalTransaksi();
                          widget.onupdate?.call();
                        });
                      },
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),
                Row(children: [
                  Container(
                    width: 20,
                  ),
                  SizedBox(
                    width: 118,
                    height: 16,
                    child: AutoSizeText(
                      "Harga Satuan",
                      minFontSize: 10,
                      maxFontSize: 12,
                      style: CustomTextStyle.StyleList(),
                    ),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  SizedBox(
                    width: 184,
                    height: 16,
                    child: TextField(
                      controller: hargaSatuanController,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.numberWithOptions(),
                      inputFormatters: [
                        CurrencyTextInputFormatter(currencyFormatter)
                      ],
                      decoration: InputDecoration(
                          hintStyle: CustomTextStyle.StyleList()),
                      // style: CustomTextStyle.StyleList(),
                      onChanged: (value) {
                        setState(() {
                          widget.data.hargaSatuan = double.parse(
                              getRawNumber(hargaSatuanController.text));
                          UpdateNominalTransaksi();
                          widget.onupdate?.call();
                        });
                      },
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),
                Row(children: [
                  Container(
                    width: 20,
                  ),
                  SizedBox(
                      width: 118,
                      height: 16,
                      child: AutoSizeText("Biaya Tambahan",
                          minFontSize: 10,
                          maxFontSize: 12,
                          style: CustomTextStyle.StyleList())),
                  SizedBox(
                    width: 33,
                  ),
                  SizedBox(
                    width: 184,
                    height: 16,
                    child: TextField(
                      controller: biayaTambahanController,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.end,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        CurrencyTextInputFormatter(currencyFormatter)
                      ],
                      decoration: InputDecoration(
                          hintStyle: CustomTextStyle.StyleList()),
                      // style: CustomTextStyle.StyleList(),
                      onChanged: (value) {
                        setState(() {
                          widget.data.biayaTambahan = double.parse(
                              getRawNumber(biayaTambahanController.text));
                          UpdateNominalTransaksi();
                          widget.onupdate?.call();
                        });
                      },
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),
                Row(children: [
                  Container(
                    width: 20,
                  ),
                  SizedBox(
                    width: 118,
                    height: 16,
                    child: AutoSizeText(
                      "Nominal Transaksi",
                      minFontSize: 10,
                      maxFontSize: 12,
                      style: CustomTextStyle.StyleList(),
                    ),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  SizedBox(
                    width: 184,
                    height: 16,
                    child: TextField(
                      controller: nominalTransaksiController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.end,
                      inputFormatters: [
                        CurrencyTextInputFormatter(currencyFormatter)
                      ],
                      // style: CustomTextStyle.StyleList(),
                      decoration: InputDecoration(
                          // border: InputBorder.none,
                          hintStyle: CustomTextStyle.StyleList()),
                      onChanged: (value) {
                        setState(() {
                          widget.data.nominalTransaksi = double.parse(
                              getRawNumber(nominalTransaksiController.text));
                          // widget.onupdate;
                          widget.onupdate?.call();
                        });
                      },
                    ),
                  ),
                ]),
                SizedBox(
                  height: 16,
                ),
                ButtonDelete(ontap: () {
                  widget.onremove?.call();
                }),
              ],
            )));
  }
}

class SummaryNewTx extends StatelessWidget {
  final String totalItem;
  final String totalTransaksi;
  final String biayaTambahan;
  final String totalTransaksiAll;

  const SummaryNewTx(
      {super.key,
      required this.totalItem,
      required this.totalTransaksi,
      required this.biayaTambahan,
      required this.totalTransaksiAll});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 150,
      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Column(
        children: [
          Container(
            width: 351,
            height: 16,
            child: Row(
              children: [
                Container(
                    width: 145,
                    child: AutoSizeText(
                      "Total Item",
                      style: CustomTextStyle.StyleList(),
                    )),
                SizedBox(
                  width: 100,
                ),
                Container(
                  width: 81,
                  child: AutoSizeText(
                    '$totalItem',
                    textAlign: TextAlign.end,
                    minFontSize: 10,
                    maxFontSize: 14,
                    style: CustomTextStyle.StyleList(),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: 351,
            height: 16,
            child: Row(
              children: [
                Container(
                    width: 145,
                    child: AutoSizeText(
                      "Total Transaksi",
                      style: CustomTextStyle.StyleList(),
                    )),
                SizedBox(
                  width: 100,
                ),
                Container(
                  width: 81,
                  child: AutoSizeText(
                    '$totalTransaksi',
                    textAlign: TextAlign.end,
                    minFontSize: 10,
                    maxFontSize: 14,
                    style: CustomTextStyle.StyleList(),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: 351,
            height: 16,
            child: Row(
              children: [
                Container(
                    width: 145,
                    child: AutoSizeText(
                      "Total Biaya Tambahan",
                      style: CustomTextStyle.StyleList(),
                    )),
                SizedBox(
                  width: 100,
                ),
                Container(
                  width: 81,
                  child: AutoSizeText(
                    '$biayaTambahan',
                    textAlign: TextAlign.end,
                    minFontSize: 10,
                    maxFontSize: 14,
                    style: CustomTextStyle.StyleList(),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: 351,
            height: 16,
            child: Row(
              children: [
                Container(
                    width: 145,
                    child: AutoSizeText(
                      "PPN (0 jika sudah termasuk)",
                      minFontSize: 10,
                      maxFontSize: 14,
                      style: CustomTextStyle.StyleList(),
                    )),
                SizedBox(
                  width: 100,
                ),
                Container(
                  width: 81,
                  child: AutoSizeText(
                    "0",
                    textAlign: TextAlign.end,
                    minFontSize: 10,
                    maxFontSize: 14,
                    style: CustomTextStyle.StyleList(),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: 351,
            height: 16,
            child: Row(
              children: [
                Container(
                    width: 145,
                    child: AutoSizeText(
                      "Total Pengeluaran",
                      style: CustomTextStyle.StyleList(),
                    )),
                SizedBox(
                  width: 100,
                ),
                Container(
                  width: 81,
                  child: AutoSizeText(
                    '$totalTransaksiAll',
                    textAlign: TextAlign.end,
                    minFontSize: 10,
                    maxFontSize: 14,
                    style: CustomTextStyle.StyleList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
