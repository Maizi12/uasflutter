import 'package:flutter/material.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/models/kategori.dart';
import 'package:uas_flutter/pages/list-coa.dart';

class CategoryList extends StatelessWidget {
  final List<GetCategoriesAndSubModel> categories;

  const CategoryList({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int categoryIndex) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category title
              Text(
                categories[categoryIndex].namaJenisCoa,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Divider()),
              // SubCategory list
              SubCategoryList(
                subcategories: categories[categoryIndex].ListCoa,
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
