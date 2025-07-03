import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/styles/textstyle.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

class DropdownCoaApp extends StatefulWidget {
  DropdownCoaApp({
    super.key,
    this.child,
    required this.onupdate,
    // this.selectedcoa,
    this.allcoa,
    required this.selectCoa,
    this.icon,
    this.itemsbuilder,
    this.items,
    required this.ListCoa,
    this.selectedcoa,
  });

  final Widget? child;
  final Widget? icon;
  final Widget? itemsbuilder;
  final Widget? items;
  final Function(List<GetCoaModel>)? allcoa;
  List<GetCoaModel> ListCoa = [
    GetCoaModel(
        namaCoa: "Create Coa", idCoa: 0, nominal: 0, kodeCoa: "", idJenisCoa: 0)
  ];
  final VoidCallback? onupdate;
  final Function(GetCoaModel) selectCoa;
  GetCoaModel? selectedcoa = GetCoaModel(
      namaCoa: "Create Coa", idCoa: 0, nominal: 0, kodeCoa: "", idJenisCoa: 0);
  @override
  State<DropdownCoaApp> createState() => DropdownCoaState();
}

class DropdownCoaState extends State<DropdownCoaApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.ListCoa.isNotEmpty) {
      // setState(() {
      //   widget.selectedcoa = widget.ListCoa.first;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ 1. Buat list baru tanpa selectedcoa
    final List<GetCoaModel> filteredList =
        widget.ListCoa.where((e) => e.idCoa != widget.selectedcoa?.idCoa)
            .toList();

    // ✅ 2. Masukin selected di awal supaya tetap muncul
    final List<GetCoaModel> finalDropdownList = [
      if (widget.selectedcoa != null) widget.selectedcoa!,
      ...filteredList,
    ];
    if (widget.selectedcoa == null ||
        widget.ListCoa.isEmpty ||
        (widget.ListCoa.length == 1 &&
            widget.ListCoa.first.namaCoa == "Create Coa")) {
      return const Center(child: CircularProgressIndicator());
    }
    return BlocListener<TransaksiCubit, TransaksiState>(
        listener: (context, state) {
          state.whenOrNull(
            failed: (String? e) {
              setState(() {
                // error = e;
              });
            },
          );
        },
        child: Container(
          child: DropdownButton<GetCoaModel>(
            value: widget.selectedcoa,

            icon: Container(
                margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: widget.icon),
            underline: const SizedBox(),
            selectedItemBuilder: (BuildContext context) {
              return finalDropdownList.map<Widget>((GetCoaModel values) {
                return widget.itemsbuilder ??
                    DropdownCoaSelected(
                      namaCoa: values.namaCoa,
                    );
              }).toList();
            },
            isExpanded: true,
            // ✅ Pakai list final yang sudah disaring
            items: finalDropdownList.map((GetCoaModel values) {
              return DropdownMenuItem<GetCoaModel>(
                  value: values,
                  child: widget.items ?? DropdownCoa(namaCoa: values.namaCoa));
            }).toList(),

            onChanged: (GetCoaModel? value) {
              setState(() {
                widget.selectedcoa = value!;
                widget.selectCoa(widget.selectedcoa!);
                widget.onupdate?.call();
              });

              if (value!.namaCoa == "Create Coa") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateCategoriesApp()));
              }
            },
            hint: AutoSizeText(
              "Pilih Akun",
              textAlign: TextAlign.end,
              style: CustomTextStyle.StyleList(),
            ),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          ),
        ));
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
              child: AutoSizeText(
                minFontSize: 14,
                maxFontSize: 16,
                namaCoa,
                textAlign: TextAlign.left,
                style: CustomTextStyle.StyleList(),
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
        SizedBox(
            // width: 184,
            // alignment: Alignment.centerRight,
            child: AutoSizeText(
                minFontSize: 14,
                maxFontSize: 16,
                namaCoa,
                style: CustomTextStyle.StyleList())),
      ],
    );
  }
}
