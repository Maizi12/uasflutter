import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/createCategory.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';
import 'package:uas_flutter/transaksi2.dart';

class CreateTransaksiApp extends StatefulWidget {
  CreateTransaksiApp({super.key});
  List<GetWalletModel>? listWallet;
  String? dropdownWalletValue;
  @override
  State<CreateTransaksiApp> createState() => CreateTransaksi();
}

TextEditingController namaTransaksiController = TextEditingController();
TextEditingController tanggalTransaksiController = TextEditingController();
TextEditingController kategori = TextEditingController();
TextEditingController dompetTransaksiController = TextEditingController();

class CreateTransaksi extends State<CreateTransaksiApp> {
  String? get dropdownWalletValue => widget.dropdownWalletValue;
  List<GetWalletModel>? get listWallet => widget.listWallet;
  @override
  void initState() {
    super.initState();
    GetWallets();
  }

  GetWallets() async {
    var getwallets = await GetWalletData("1", "10", "");
    setState(() {
      widget.listWallet = getwallets;
      widget.dropdownWalletValue = getwallets.first.NamaWallet;
      widget.listWallet!.add(GetWalletModel(
          NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 375,
      height: 820,
      decoration: const BoxDecoration(
        color: Color(0xffF5F7FF),
      ),
      child: Column(children: [
        const SizedBox(
          height: 44,
        ),
        SizedBox(
          width: 375,
          height: 40,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: IconButton(
                    iconSize: 24,
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  )),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 20, 0, 0),
                width: 125,
                height: 24,
                child: const Text(
                  'Buat Transaksi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    // color: Color.fromARGB(0, 0, 0, 0),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          width: 343,
          height: 42,
          margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Row(children: [
            Container(
                width: 165.5,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(1, 245, 247, 255),
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Pengeluaran",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
            Container(
                width: 165.5,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0c000000),
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Pemasukan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ))
          ]),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          width: 335,
          height: 575,
          margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(children: [
            Container(
                child: const Center(
              child: Text(
                "JUMLAH TRANSAKSI",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Row(children: [
                Container(
                    width: 36,
                    height: 36,
                    margin: const EdgeInsets.fromLTRB(11, 0, 0, 0),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(17, 10, 0, 0),
                      child: SvgPicture.asset(
                        'assets/button-rounded-minus.svg',
                        height: 24,
                        width: 24,
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.fromLTRB(104, 0, 0, 0),
                  child: const Text(
                    "0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(240, 29, 1, 214)),
                  ),
                ),
                Container(
                    width: 36,
                    height: 36,
                    margin: const EdgeInsets.fromLTRB(110, 4, 0, 0),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                      child: SvgPicture.asset(
                        'assets/button-rounded-plus.svg',
                        height: 24,
                        width: 24,
                      ),
                    )),
              ]),
            ),
            const Divider(thickness: 1, color: Colors.black),
            SizedBox(
              width: 335,
              height: 33,
              child: Row(
                children: [
                  Container(
                      width: 99,
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(117, 0, 102, 255),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Rp 100,000",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 44, 20, 221)),
                        ),
                      )),
                  const SizedBox(
                    width: 3,
                  ),
                  Container(
                      width: 99,
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(117, 0, 102, 255),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Rp 500,000",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 44, 20, 221)),
                        ),
                      )),
                  const SizedBox(
                    width: 7,
                  ),
                  Container(
                      width: 99,
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(117, 0, 102, 255),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Rp 1,000,000",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 44, 20, 221)),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              width: 335,
              height: 55,
              margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: SizedBox(
                width: 271,
                height: 50,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text("Nama Transaksi",
                            style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5C616F))),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: const Text("Beli Makan",
                            style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff3E3E3E))),
                      )
                    ]),
              ),
            ),
            Container(
              width: 335,
              height: 55,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(children: [
                SizedBox(
                  width: 271,
                  height: 50,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text("Tanggal Transaksi",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5C616F))),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: const Text("Pilih Tanggal",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff3E3E3E))),
                        )
                      ]),
                ),
                Container(
                    child: Center(
                        child: SvgPicture.asset(
                  'assets/Calendar.svg',
                  width: 18,
                  height: 20,
                )))
              ]),
            ),
            Container(
              width: 335,
              height: 71,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(children: [
                SizedBox(
                  width: 271,
                  height: 50,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text("Kategori",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5C616F))),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: const Text("Pilih Kategori",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff3E3E3E))),
                        )
                      ]),
                ),
                Container(
                    child: Center(
                        child: SvgPicture.asset(
                  'assets/chevron-left.svg',
                  width: 20,
                  height: 20,
                )))
              ]),
            ),
            Container(
              width: 335,
              height: 71,
              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(children: [
                SizedBox(
                  width: 335,
                  height: 50,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text("Pilih Dompet",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5C616F))),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                            height: 20,
                            child: Row(
                              children: [
                                Container(
                                  // frame204Jp (116:2555)
                                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    'assets/Logo.svg',
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                                Container(
                                  child: DropdownButton<String>(
                                      underline: const SizedBox(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          widget.dropdownWalletValue = value;
                                        });
                                        if (dropdownWalletValue ==
                                            "Create Wallet") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CreateCategoriesApp()));
                                        }
                                      },
                                      value: dropdownWalletValue,
                                      icon: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            15, 0, 0, 0),
                                        child: SvgPicture.asset(
                                          'assets/chevron-left.svg',
                                          height: 16,
                                          width: 16,
                                        ),
                                      ),
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      items: widget.listWallet!
                                          .map((map) => DropdownMenuItem(
                                              value: map.NamaWallet,
                                              child: Wrap(children: [
                                                Text(map.NamaWallet),
                                                Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        10, 0, 0, 0),
                                                    child: Text(
                                                        CurrencyFormat
                                                            .convertToIdr(
                                                                map.TotalSaldo,
                                                                2),
                                                        textAlign:
                                                            TextAlign.right))
                                              ])))
                                          .toList()),
                                ),
                              ],
                            )),
                      ]),
                ),
              ]),
            )
          ]),
        ),
        Container(
          width: 335,
          height: 48,
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          decoration: BoxDecoration(
            color: const Color(0xff2c14dd),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Center(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Transaksi2App()));
              },
              child: const Text(
                'Tambah',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.26,
                  color: Color(0xfffbfbfb),
                ),
              ),
            )),
          ),
        ),
      ]),
    ));
  }
}
