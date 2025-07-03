import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:uas_flutter/pages/styles/textstyle.dart';

class DropdownDisplayItemApp extends StatefulWidget {
  DropdownDisplayItemApp({
    super.key,
    this.child,
    required this.onupdate,
    this.icon,
    this.itemsbuilder,
    this.items,
    required this.selectDisplayItem,
  });

  final Widget? child;
  final Widget? icon;
  final Widget? itemsbuilder;
  final Widget? items;
  final List<int> ListDisplayItem = [10, 20, 50, 100];
  int selectedDisplayItem = 10;
  final VoidCallback? onupdate;
  final Function(int) selectDisplayItem;
  @override
  State<DropdownDisplayItemApp> createState() => DropdownDisplayItemState();
}

class DropdownDisplayItemState extends State<DropdownDisplayItemApp> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.toStringDeep());
    return SizedBox(
      child: DropdownButton<int>(
        isExpanded: true,
        value: widget.selectedDisplayItem,
        alignment: Alignment.centerRight,
        icon: Container(
            margin: const EdgeInsets.fromLTRB(8, 0, 0, 0), child: widget.icon),
        underline: const SizedBox(),
        selectedItemBuilder: (BuildContext context) {
          return widget.ListDisplayItem.map<Widget>((int values) {
            return widget.itemsbuilder ??
                DropdownDisplayItemSelected(
                  NamaDisplayItem: values.toString(),
                );
          }).toList();
        },
        items: widget.ListDisplayItem.map((int values) {
          return DropdownMenuItem<int>(
              value: values,
              child: widget.items ??
                  DropdownDisplayItem(
                    NamaDisplayItem: values.toString(),
                  ));
        }).toList(),
        onChanged: (int? value) {
          setState(() {
            widget.selectDisplayItem(value!);
            widget.selectedDisplayItem = value;
            widget.onupdate?.call();
          });
        },
        hint: AutoSizeText(
          "Pilih Tampilkan",
          textAlign: TextAlign.end,
          style: CustomTextStyle.StyleList(),
        ),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      ),
    );
  }
}

class DropdownDisplayItemSelected extends StatelessWidget {
  DropdownDisplayItemSelected({required this.NamaDisplayItem});
  final String NamaDisplayItem;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SizedBox(
            width: 90,
            child: AutoSizeText(
              minFontSize: 12,
              maxFontSize: 16,
              NamaDisplayItem,
              textAlign: TextAlign.right,
              style: CustomTextStyle.StyleList(),
            )),
      ],
    );
  }
}

class DropdownDisplayItem extends StatelessWidget {
  DropdownDisplayItem({required this.NamaDisplayItem});
  final String NamaDisplayItem;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SizedBox(
            // width: 40,
            // alignment: Alignment.centerRight,
            child: AutoSizeText(
                minFontSize: 20,
                maxFontSize: 24,
                NamaDisplayItem,
                style: CustomTextStyle.StyleList())),
      ],
    );
  }
}
