import 'package:flutter/material.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/pages/all-coa.dart';
import 'package:uas_flutter/pages/edit-Coa.dart';

class SubCategoryList extends StatelessWidget {
  final List<GetCoaModel> subcategories;

  const SubCategoryList({Key? key, required this.subcategories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: subcategories.length,
      itemBuilder: (BuildContext context, int subcategoryIndex) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 238, 242, 248),
            child: Text(
              subcategories[subcategoryIndex].namaCoa.isNotEmpty
                  ? subcategories[subcategoryIndex].namaCoa[0].toUpperCase()
                  : '?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 44, 20, 221)),
            ),
          ),
          title: Text(
            subcategories[subcategoryIndex].namaCoa,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.26,
              color: Color(0xff2c14dd),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CoaApp(
                          namaCoa: subcategories[subcategoryIndex].namaCoa,
                          kodeCoa: subcategories[subcategoryIndex].kodeCoa,
                        )));
          },
          trailing: Text(
            CurrencyFormat.convertToIdr(
                subcategories[subcategoryIndex].nominal, 2),
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.26,
              color: Color(0xff1fde00),
            ),
          ),
        );
      },
    );
  }
}
