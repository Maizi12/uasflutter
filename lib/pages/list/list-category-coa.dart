import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/models/kategori.dart';
import 'package:uas_flutter/pages/components/dropdown-display-item.dart';
import 'package:uas_flutter/pages/components/dropdown-sort.dart';
import 'package:uas_flutter/pages/list/list-coa.dart';
import 'package:uas_flutter/pages/styles/textstyle.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'dart:math' as math;

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.categories});
  final List<GetCategoriesAndSubModel> categories;
  @override
  State<CategoryList> createState() => CategoryListAll();
}

class CategoryListAll extends State<CategoryList> {
  final List<String> listSort = [
    // "Terbaru", "Terlama",
    "A",
    "Z",
    "Terbesar",
    "Terkecil"
  ];
  String selectedlistSort = "A";
  bool _customTileExpanded = false;
  final List<int> listSortTampil = [10, 20, 50, 100];
  int selectedlistSortTampil = 10;
  Sort(int categoryIndex) {
    if (selectedlistSort == "Terbesar") {
      widget.categories[categoryIndex].ListCoa
          .sort((a, b) => b.nominal.compareTo(a.nominal));
    } else if (selectedlistSort == "Terkecil") {
      widget.categories[categoryIndex].ListCoa
          .sort((a, b) => a.nominal.compareTo(b.nominal));
    } else if (selectedlistSort == "A") {
      widget.categories[categoryIndex].ListCoa
          .sort((a, b) => a.namaCoa.compareTo(b.namaCoa));
    } else if (selectedlistSort == "Z") {
      widget.categories[categoryIndex].ListCoa
          .sort((a, b) => b.namaCoa.compareTo(a.namaCoa));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.categories.length,
      itemBuilder: (BuildContext context, int categoryIndex) {
        return SizedBox(
          width: 393,
          // height: 456,
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.white,
              dividerTheme: DividerThemeData(
                color: Colors.white,
              ),
            ),
            child: ExpansionTile(
              collapsedShape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: Colors.white, // Matches the background
              collapsedBackgroundColor:
                  Colors.white, // Ensures consistency when collapsed
              onExpansionChanged: (value) {
                setState(() {
                  _customTileExpanded = value;
                });
              },
              title: Title(
                color: Colors.black,
                child: SizedBox(
                  width: 184,
                  child: AutoSizeText(
                    minFontSize: 10,
                    maxFontSize: 16,
                    maxLines: 1,
                    widget.categories[categoryIndex].namaJenisCoa,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Plus Jakarta Sans"),
                  ),
                ),
              ),
              trailing: Container(
                width: 200,
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        "Urutkan:",
                        style: CustomTextStyle.StyleList(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                      width: 110,
                      height: 20,
                      // decoration:
                      //     BoxDecoration(border: Border.all(color: Colors.red)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownSortApp(
                          onupdate: () {
                            setState(() {
                              // RecentTx();
                              Sort(categoryIndex);
                            });
                          },
                          icon: Icon(
                            _customTileExpanded
                                ? Icons.arrow_drop_down
                                : Icons.arrow_right,
                          ),
                          selectSort: (String) {
                            setState(() {
                              selectedlistSort = String;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              children: [
                SubCategoryList(
                  subcategories: widget.categories[categoryIndex].ListCoa,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Category {
  final String name;
  final List<GetCoaModel> subcategories;

  Category({required this.name, required this.subcategories});
}

class SubCategory {
  final String name;

  SubCategory({required this.name});
}
