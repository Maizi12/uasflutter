import 'package:uas_flutter/models/stats.dart';
import 'package:uas_flutter/resources/app_resources.dart';
import 'package:uas_flutter/extensions/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'models/response-go.dart';

class BarChartSample4 extends StatefulWidget {
  BarChartSample4(
      {super.key,
      required this.getberanda,
      required this.isHarian,
      required this.isMingguan,
      required this.isBulanan});
  int isHarian;
  int isMingguan;
  int isBulanan;
  List<BarChartGroupData> chart = List.empty();
  String Textsebelumnya = "";
  int XSebelumnya = 0;
  GetBerandaModel getberanda;
  final Color dark = AppColors.contentColorCyan.darken(60);
  final Color normal = AppColors.contentColorCyan.darken(30);
  final Color light = AppColors.contentColorCyan;
  late double barsSpace = 0.0;
  late double barsWidth = 0.0;
  late BoxConstraints constraints = BoxConstraints();
  late List<StatsModel> Value;

  @override
  State<StatefulWidget> createState() => BarChartSample4State();
}

class BarChartSample4State extends State<BarChartSample4> {
  List<StatsModel> get Value => widget.Value;
  Beranda() async {
    Value.length = 28;
    for (var i = 0; i < Value.length; i++) {
      //  Value[i].debit=
    }
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 8);

    String text = "";

    if (widget.isBulanan != 0) {
      widget.getberanda.bulanan[value.toInt()].Used += 1;
      text = widget.getberanda.bulanan[value.toInt()].WaktuTransaksi;
    } else if (widget.isMingguan != 0) {
      widget.getberanda.pekanan[value.toInt()].Used += 1;
      text = widget.getberanda.pekanan[value.toInt()].WaktuTransaksi;
    } else if (widget.isHarian != 0) {
      widget.getberanda.harian[value.toInt()].Used += 1;
      text = widget.getberanda.harian[value.toInt()].WaktuTransaksi;
    }
    print("text");
    print(value.toInt());
    print(text);
    // widget.XSebelumnya+=1;

    // switch (value.toInt()) {
    //   case 0:
    //     break;
    //   case 1:
    //     text = 'May';
    //     break;
    //   case 2:
    //     text = 'Jun';
    //     break;
    //   case 3:
    //     text = 'Jul';
    //     break;
    //   case 4:
    //     text = 'Aug';
    //     break;
    //   default:
    //     text = '';
    //     break;
    // }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  int touchedIndex = -1;
  // Contstraint() {
  //   setState(() {
  //     widget.constraints = constraints;
  //     widget.barsSpace = 4.0 * constraints.maxWidth / 100;
  //     widget.barsWidth = 8.0 * constraints.maxWidth / 100;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            widget.barsSpace = 4.0 * constraints.maxWidth / 100;
            widget.barsWidth = 8.0 * constraints.maxWidth / 100;
            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: ((group) {
                      return Colors.grey;
                    }),
                    getTooltipItem: (a, b, c, d) => null,
                  ),
                  touchCallback: (FlTouchEvent event, barTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          barTouchResponse == null ||
                          barTouchResponse.spot == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          barTouchResponse.spot!.touchedBarGroupIndex;
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: bottomTitles,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 10 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.borderColor.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                groupsSpace: widget.barsSpace,
                barGroups: getData(widget.barsWidth, widget.barsSpace),
              ),
            );
          },
        ),
      ),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    if (widget.isHarian != 0) {
      List<BarChartGroupData> chart = List.filled(
          widget.getberanda.harian.length, BarChartGroupData(x: 0),
          growable: true);
      for (var i = 0; i < widget.getberanda.harian.length; i++) {
        chart.add(BarChartGroupData(
          x: i,
          barsSpace: barsSpace,
          barRods: [
            BarChartRodData(
              toY: (widget.getberanda.harian[i].Debit +
                      widget.getberanda.harian[i].Kredit)
                  .toDouble(),
              rodStackItems: [
                BarChartRodStackItem(0,
                    widget.getberanda.harian[i].Debit.toDouble(), widget.dark),
                BarChartRodStackItem(
                    widget.getberanda.harian[i].Debit.toDouble(),
                    widget.getberanda.harian[i].Kredit.toDouble(),
                    widget.normal),
                // BarChartRodStackItem(12000000000, 17000000000, widget.light),
              ],
              borderRadius: BorderRadius.zero,
              width: barsWidth,
            ),
          ],
        ));
      }
      return chart;
    } else if (widget.isMingguan != 0) {
      List<BarChartGroupData> chart = List.filled(
          widget.getberanda.pekanan.length, BarChartGroupData(x: 0),
          growable: true);
      for (var i = 0; i < widget.getberanda.pekanan.length; i++) {
        chart.add(BarChartGroupData(
          x: i,
          barsSpace: barsSpace,
          barRods: [
            BarChartRodData(
              toY: (widget.getberanda.pekanan[i].Debit +
                      widget.getberanda.pekanan[i].Kredit)
                  .toDouble(),
              rodStackItems: [
                BarChartRodStackItem(0,
                    widget.getberanda.pekanan[i].Debit.toDouble(), widget.dark),
                BarChartRodStackItem(
                    widget.getberanda.pekanan[i].Debit.toDouble(),
                    widget.getberanda.pekanan[i].Kredit.toDouble(),
                    widget.normal),
                // BarChartRodStackItem(12000000000, 17000000000, widget.light),
              ],
              borderRadius: BorderRadius.zero,
              width: barsWidth,
            ),
          ],
        ));
      }
      return chart;
    } else {
      print("widget.getberanda.bulanan.length");
      print(widget.getberanda.bulanan.length);
      List<BarChartGroupData> chart = List.filled(
          widget.getberanda.bulanan.length, BarChartGroupData(x: 0),
          growable: true);
      for (var i = 0; i < widget.getberanda.bulanan.length; i++) {
        chart.add(BarChartGroupData(
          x: i,
          barsSpace: barsSpace,
          barRods: [
            BarChartRodData(
              toY: (widget.getberanda.bulanan[i].Debit +
                      widget.getberanda.bulanan[i].Kredit)
                  .toDouble(),
              rodStackItems: [
                BarChartRodStackItem(0,
                    widget.getberanda.bulanan[i].Debit.toDouble(), widget.dark),
                BarChartRodStackItem(
                    widget.getberanda.bulanan[i].Debit.toDouble(),
                    widget.getberanda.bulanan[i].Kredit.toDouble(),
                    widget.normal),
                // BarChartRodStackItem(12000000000, 17000000000, widget.light),
              ],
              borderRadius: BorderRadius.zero,
              width: barsWidth,
            ),
          ],
        ));
      }
      return chart;
    }
  }
}
