import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:uas_flutter/pages/styles/textstyle.dart';

class DropdownSortApp extends StatefulWidget {
  DropdownSortApp({
    super.key,
    this.child,
    required this.onupdate,
    this.icon,
    this.itemsbuilder,
    this.items,
    required this.selectSort,
  });

  final Widget? child;
  final Widget? icon;
  final Widget? itemsbuilder;
  final Widget? items;
  final List<String> listSort = ["Terbaru", "Terlama", "Terbesar", "Terkecil"];
  String selectedSort = "Terbaru";
  final VoidCallback? onupdate;
  final Function(String) selectSort;
  @override
  State<DropdownSortApp> createState() => DropdownSortState();
}

class DropdownSortState extends State<DropdownSortApp> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.toStringDeep());
    return SizedBox(
      child: DropdownButton<String>(
        value: widget.selectedSort,
        isExpanded: true,
        alignment: Alignment.centerRight,
        icon: Container(
            margin: const EdgeInsets.fromLTRB(8, 0, 0, 0), child: widget.icon),
        underline: const SizedBox(),
        selectedItemBuilder: (BuildContext context) {
          return widget.listSort.map<Widget>((String values) {
            return widget.itemsbuilder ??
                DropdownSortSelected(
                  namaSort: values,
                );
          }).toList();
        },
        items: widget.listSort.map((String values) {
          return DropdownMenuItem<String>(
              value: values,
              child: widget.items ??
                  DropdownSort(
                    namaSort: values,
                  ));
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            widget.selectSort(value!);
            widget.selectedSort = value;
            widget.onupdate?.call();
          });
        },
        hint: AutoSizeText(
          "Pilih Urutan",
          textAlign: TextAlign.end,
          style: CustomTextStyle.StyleList(),
        ),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      ),
    );
  }
}

class DropdownSortSelected extends StatelessWidget {
  const DropdownSortSelected({super.key, required this.namaSort});
  final String namaSort;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SizedBox(
            width: 90,
            child: AutoSizeText(
              minFontSize: 12,
              maxFontSize: 16,
              namaSort,
              textAlign: TextAlign.right,
              style: CustomTextStyle.StyleList(),
            )),
      ],
    );
  }
}

class DropdownSort extends StatelessWidget {
  const DropdownSort({super.key, required this.namaSort});
  final String namaSort;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SizedBox(
            // width: 50,
            // alignment: Alignment.centerRight,
            child: AutoSizeText(
                minFontSize: 20,
                maxFontSize: 24,
                namaSort,
                style: CustomTextStyle.StyleList())),
      ],
    );
  }
}
