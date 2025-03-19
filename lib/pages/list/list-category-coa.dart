import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/models/kategori.dart';
import 'package:uas_flutter/pages/list/list-coa.dart';
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
  final int selectedlistSortTampil = 10;
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
        return Container(
          width: 393,
          // height: 456,
          child: ExpansionTile(
            onExpansionChanged: (value) {
              print("value");
              print(value);
              setState(() {
                _customTileExpanded = value;
              });
            },
            title: Title(
              color: Colors.black,
              child: Container(
                width: 184,
                child: AutoSizeText(
                  minFontSize: 12,
                  maxFontSize: 18,
                  widget.categories[categoryIndex].namaJenisCoa,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Plus Jakarta Sans"),
                ),
              ),
            ),
            trailing: SizedBox(
              width: 200,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 16,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: const Text(
                      "Urutkan:",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                    width: 104,
                    height: 20,
                    child: DropdownButton<String>(
                      value: selectedlistSort,
                      // underline: const SizedBox(),
                      items: listSort.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Wrap(children: [
                              AutoSizeText(
                                value,
                                minFontSize: 12,
                                maxFontSize: 18,
                              ),
                            ]));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedlistSort = value!;
                          Sort(categoryIndex);
                          // RecentTx();
                        });
                        if (value! == "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateCategoriesApp()));
                        }
                      },
                      icon: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SvgPicture.asset(
                          'assets/caret-arrow-up.svg',
                          height: 16,
                          width: 16,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    _customTileExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
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
