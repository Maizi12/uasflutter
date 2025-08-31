import 'package:flutter/material.dart';
import 'package:digit/data/models/response_go.dart';

class DropdownWalletApp extends StatefulWidget {
  DropdownWalletApp({
    super.key,
    this.child,
    required this.onupdate,
    this.allcoa,
    required this.selectCoa,
    this.icon,
    this.itemsbuilder,
    this.items,
    List<GetWalletModel>? ListCoa,
    GetWalletModel? selectedcoa,
  })  : ListCoa = ListCoa ??
            [
              GetWalletModel(
                  NamaWallet: "Create Wallet",
                  idWallet: 0,
                  TotalSaldo: 0,
                  KodeCoa: "")
            ],
        selectedcoa = selectedcoa ??
            GetWalletModel(
                NamaWallet: "Create Wallet",
                idWallet: 0,
                TotalSaldo: 0,
                KodeCoa: "");
  final List<GetWalletModel> ListCoa;
  final VoidCallback? onupdate;
  final Function(GetWalletModel) selectCoa;
  final GetWalletModel? selectedcoa;
  final Widget? child;
  final Widget? icon;
  final Widget? itemsbuilder;
  final Widget? items;
  final Function(List<GetWalletModel>)? allcoa;
  // List<GetWalletModel> ListCoa = [
  // GetWalletModel(
  // NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0, KodeCoa: "")
  // ];
  // final VoidCallback? onupdate;
  // final Function(GetWalletModel) selectCoa;
  // GetWalletModel? selectedcoa = GetWalletModel(
  //     NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0, KodeCoa: "");

  @override
  State<DropdownWalletApp> createState() => DropdownWalletState();
}

class DropdownWalletState extends State<DropdownWalletApp> {
  @override
  void initState() {
    super.initState();
    if (widget.ListCoa.isNotEmpty) {
      // Initialize if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    // Create list without selectedcoa

    final List<GetWalletModel> filteredList =
        widget.ListCoa.where((e) => e.idWallet != widget.selectedcoa?.idWallet)
            .toList();

    final List<GetWalletModel> finalDropdownList = [
      if (widget.selectedcoa != null) widget.selectedcoa!,
      ...filteredList,
    ];
    widget.ListCoa.where((e) => e.idWallet != widget.selectedcoa?.idWallet)
        .toList();

    // If selectedcoa is not in ListCoa, use the first item for display
    final GetWalletModel? selectedCoaToUse = (widget.selectedcoa == null ||
            !widget.ListCoa.any(
                (e) => e.idWallet == widget.selectedcoa?.idWallet))
        ? widget.ListCoa.first
        : widget.selectedcoa;

    return Container(
      child: DropdownButton<GetWalletModel>(
        isDense: true,
        value: selectedCoaToUse,
        icon: Container(
            margin: const EdgeInsets.fromLTRB(8, 0, 0, 0), child: widget.icon),
        underline: const SizedBox(),
        selectedItemBuilder: (BuildContext context) {
          return finalDropdownList.map<Widget>((GetWalletModel values) {
            return widget.itemsbuilder ??
                DropdownCoaSelected(
                  namaCoa: values.NamaWallet,
                );
          }).toList();
        },
        isExpanded: true,
        items: finalDropdownList.map((GetWalletModel values) {
          return DropdownMenuItem<GetWalletModel>(
              value: values,
              child: widget.items ?? DropdownCoa(namaCoa: values.NamaWallet));
        }).toList(),
        onChanged: (GetWalletModel? value) {
          setState(() {
            widget.selectCoa(value!);
            widget.onupdate?.call();
          });

          if (value!.NamaWallet == "Create Wallet") {
            // Navigate to create wallet
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const CreateCategoriesApp()));
          }
        },
        hint: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Pilih Akun",
            textAlign: TextAlign.end,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff5C616F),
            ),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      ),
    );
  }
}

class DropdownCoaSelected extends StatelessWidget {
  DropdownCoaSelected({super.key, required this.namaCoa});
  final String namaCoa;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SizedBox(
            width: 110,
            height: 30,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                namaCoa,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff5C616F),
                ),
              ),
            )),
      ],
    );
  }
}

class DropdownCoa extends StatelessWidget {
  DropdownCoa({super.key, required this.namaCoa});
  final String namaCoa;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          textAlign: TextAlign.left,
          namaCoa,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff5C616F),
          ),
        ),
      ],
    );
  }
}
