import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/models/kategori.dart';
import 'package:uas_flutter/pages/list/list-coa.dart';
import 'package:uas_flutter/view/category/createCategory.dart';

class CategoryList extends StatefulWidget {
  CategoryList({super.key, required this.categories});
  final List<GetCategoriesAndSubModel> categories;
  State<CategoryList> createState() => CategoryListAll();
}

class CategoryListAll extends State<CategoryList> {
  final List<String> listSort = ["Terbaru", "Terlama", "Terbesar", "Terkecil"];
  String selectedlistSort = "Terbaru";
  final List<int> listSortTampil = [10, 20, 50, 100];
  final int selectedlistSortTampil = 10;
  @override
  Widget build(BuildContext context) {
  print("widget.categories.length");
  print(widget.categories.length);
    return ListView.builder(
      itemCount: widget.categories.length,
      itemBuilder: (BuildContext context, int categoryIndex) {
        return Container(
          width: 393,
          // height: 456,
          child: ExpansionTile(
            title: Title(
              color: Colors.black,
              child: Text(
                widget.categories[categoryIndex].namaJenisCoa,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Plus Jakarta Sans"),
              ),
            ),
            trailing: SizedBox(
              width: 200,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 20,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: const Text(
                      "Urutkan:",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                    width: 85,
                    height: 20,
                    child: DropdownButton<String>(
                      value: selectedlistSort,
                      // underline: const SizedBox(),
                      items: listSort.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Wrap(children: [
                              Text(value),
                            ]));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedlistSort = value!;
                          // RecentTx();
                          if (selectedlistSort == "Terbaru") {
                            // tagObjs.sort((a, b) =>
                            //     a.WaktuTransaksi.compareTo(b.WaktuTransaksi));
                          } else {
                            // tagObjs.sort((a, b) =>
                            //     a.WaktuTransaksi.compareTo(b.WaktuTransaksi));
                          }
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
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      'assets/chevron-left.svg',
                      height: 16,
                      width: 16,
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
        );

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category title
              Container(
                width: 393,
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      child: Text(
                        widget.categories[categoryIndex].namaJenisCoa,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Plus Jakarta Sans"),
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Container(
                      width: 48,
                      height: 20,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: const Text(
                        "Urutkan:",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                      width: 85,
                      height: 20,
                      child: DropdownButton<String>(
                        value: selectedlistSort,
                        // underline: const SizedBox(),
                        items: listSort.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Wrap(children: [
                                Text(value),
                              ]));
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedlistSort = value!;
                            // RecentTx();
                            if (selectedlistSort == "Terbaru") {
                              // tagObjs.sort((a, b) =>
                              //     a.WaktuTransaksi.compareTo(b.WaktuTransaksi));
                            } else {
                              // tagObjs.sort((a, b) =>
                              //     a.WaktuTransaksi.compareTo(b.WaktuTransaksi));
                            }
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
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        'assets/chevron-left.svg',
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  )),
              // SubCategory list
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
