// widgets/dashboard_header.dart
import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:digit/presentation/widgets/dropdown_wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashboardHeader extends StatelessWidget {
  final List<GetWalletModel> wallets;
  final GetWalletModel? selectedWallet;
  final Function(GetWalletModel) onWalletChanged;

  const DashboardHeader({
    super.key,
    required this.wallets,
    required this.selectedWallet,
    required this.onWalletChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/Logo.svg',
                height: AppDimensions.logoSize,
                width: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownWalletApp(
                  ListCoa: wallets,
                  selectedcoa: selectedWallet ?? GetWalletModel.empty(),
                  selectCoa: onWalletChanged,
                  onupdate: () {}, // Remove this callback, handled by cubit
                  icon: SvgPicture.asset(
                    'assets/caret-arrow-up.svg',
                    height: AppDimensions.iconSize,
                    width: AppDimensions.iconSize,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Keuangan Kamu Terlihat Sehat",
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
