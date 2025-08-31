import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:digit/presentation/cubits/wallet/wallet_cubit.dart';
import 'package:digit/presentation/cubits/wallet/wallet_state.dart';
import 'package:flutter/material.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class DropdownWalletApp extends StatefulWidget {
//   DropdownWalletApp({
//     super.key,
//     this.child,
//     required this.onupdate,
//     this.allcoa,
//     required this.selectCoa,
//     this.icon,
//     this.itemsbuilder,
//     this.items,
//     List<GetWalletModel>? ListCoa,
//     GetWalletModel? selectedcoa,
//   })  : ListCoa = ListCoa ??
//             [
//               GetWalletModel(
//                   NamaWallet: "Create Wallet",
//                   idWallet: 0,
//                   TotalSaldo: 0,
//                   KodeCoa: "")
//             ],
//         selectedcoa = selectedcoa ??
//             GetWalletModel(
//                 NamaWallet: "Create Wallet",
//                 idWallet: 0,
//                 TotalSaldo: 0,
//                 KodeCoa: "");
//   final List<GetWalletModel> ListCoa;
//   final VoidCallback? onupdate;
//   final Function(GetWalletModel) selectCoa;
//   GetWalletModel? selectedcoa;
//   final Widget? child;
//   final Widget? icon;
//   final Widget? itemsbuilder;
//   final Widget? items;
//   final Function(List<GetWalletModel>)? allcoa;
//   // List<GetWalletModel> ListCoa = [
//   // GetWalletModel(
//   // NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0, KodeCoa: "")
//   // ];
//   // final VoidCallback? onupdate;
//   // final Function(GetWalletModel) selectCoa;
//   // GetWalletModel? selectedcoa = GetWalletModel(
//   //     NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0, KodeCoa: "");

//   @override
//   // State<DropdownWalletApp> createState() => DropdownWalletState();
// }

class DropdownWallet extends StatelessWidget {
  final Widget icon;
  DropdownWallet({super.key, required this.icon});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletCubit, WalletState>(listener: (context, state) {
      if (state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage ?? 'An error occurred'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }, builder: (context, state) {
      return _buildContent(state, icon, context);
    });
  }
}

Widget _buildContent(WalletState state, Widget icon, BuildContext context) {
  return Container(
    child: DropdownButton<GetWalletModel>(
      isDense: true,
      value: state.selectedWallet,
      icon:
          Container(margin: const EdgeInsets.fromLTRB(8, 0, 0, 0), child: icon),
      underline: const SizedBox(),
      selectedItemBuilder: (BuildContext context) {
        return state.wallets.map<Widget>((GetWalletModel values) {
          return DropdownCoaSelected(
            namaCoa: values.NamaWallet,
          );
        }).toList();
      },
      isExpanded: true,
      items: state.wallets.map((GetWalletModel values) {
        return DropdownMenuItem<GetWalletModel>(
            value: values, child: DropdownCoa(namaCoa: values.NamaWallet));
      }).toList(),
      onChanged: (GetWalletModel? value) {
        context.read<WalletCubit>().selectWallet(value!);
      },
      hint: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Pilih Akun",
          textAlign: TextAlign.end,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff5C616F),
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    ),
  );
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
              child: Text(
                namaCoa,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff5C616F),
                ),
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
        Text(
          textAlign: TextAlign.left,
          namaCoa,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff5C616F),
          ),
        ),
      ],
    );
  }
}
