import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:uas_flutter/pages/styles/textstyle.dart';

class SelectDateApp extends StatefulWidget {
  const SelectDateApp(
      {super.key, required this.onDateSelected, this.child, required this.tgl});

  final Function(DateTime) onDateSelected;
  final Function(String) tgl;
  final Widget? child;
  @override
  State<SelectDateApp> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDateApp> {
  @override
  void initState() {
    super.initState();
  }

  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: selectedDate,
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });

      // Pass the selected date to the parent widget
      widget.onDateSelected(selectedDate);
      // widget.tgl(DateFormat.yMMMEd(picked).toString());
      widget.tgl(DateFormat.yMMMMd("id_ID").format(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _selectDate(context),
        child: widget.child);
  }
}

class SelectDateRangeApp extends StatefulWidget {
  const SelectDateRangeApp(
      {super.key,
      required this.tgl,
      required this.onDatesSelected,
      this.child,
      required this.tglAwal,
      required this.tglAkhir});

  final Function(String) tgl;
  final Function(DateTimeRange) onDatesSelected;
  final Function(String) tglAwal;
  final Function(String) tglAkhir;

  final Widget? child;
  @override
  State<SelectDateRangeApp> createState() => _SelectDateRangeState();
}

class _SelectDateRangeState extends State<SelectDateRangeApp> {
  DateTimeRange selectedDate = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 30)));

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: selectedDate,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        if (selectedDate.start.day != 0 && selectedDate.end.day != 0) {
          widget.tgl(
              '${DateFormat.yMMMMd("id_ID").format(picked.start)} - ${DateFormat.yMMMMd("id_ID").format(picked.end)}');
        } else if (selectedDate.start.day != 0) {
          widget.tgl(DateFormat.yMMMMd("id_ID").format(picked.start));
        } else {
          widget.tgl(DateFormat.yMMMMd("id_ID").format(picked.end));
        }
      });
      widget.tglAwal(DateFormat.yMMMMd("id_ID").format(picked.start));
      widget.tglAkhir(DateFormat.yMMMMd("id_ID").format(picked.end));
      // Pass the selected date to the parent widget
      widget.onDatesSelected(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _selectDate(context),
        child: widget.child);
  }
}

class SelectDateMultiTx extends StatelessWidget {
  final String selectedDate;

  const SelectDateMultiTx({super.key, required this.selectedDate});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: 375,
      height: 16,
      child: Row(
        children: [
          Container(width: 20),
          SizedBox(
            width: 118,
            height: 16,
            child: Text(
              "Tanggal Transaksi",
              style: CustomTextStyle.StyleList(),
            ),
          ),
          SizedBox(width: 33),
          SizedBox(
            width: 184,
            height: 16,
            child: AutoSizeText(
              selectedDate,
              textAlign: TextAlign.end,
              minFontSize: 10,
              maxFontSize: 12,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SelectDateEditTx extends StatelessWidget {
  final String selectedDate;

  const SelectDateEditTx({super.key, required this.selectedDate});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: 375,
      height: 16,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 240,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "Tanggal Transaksi",
                  style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              SizedBox(
                  width: 240,
                  child: SizedBox(
                    width: 184,
                    // height: 16,
                    child: AutoSizeText(
                      selectedDate,
                      textAlign: TextAlign.left,
                      minFontSize: 14,
                      maxFontSize: 14,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Container(
              width: 40,
              height: 40,
              child: SvgPicture.asset(
                'assets/Calendar.svg',
              ))
        ],
      ),
    );
  }
}

class SelectDateDefault extends StatelessWidget {
  final String selectedDate;
  const SelectDateDefault({super.key, required this.selectedDate});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 180,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: const Text(
                "Rentang Tanggal Transaksi",
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: 180,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(selectedDate,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff3E3E3E),
                  )),
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Container(
            width: 40,
            height: 40,
            child: SvgPicture.asset(
              'assets/Calendar.svg',
            ))
      ],
    );
  }
}
