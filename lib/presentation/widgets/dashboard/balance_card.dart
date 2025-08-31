// widgets/balance_card.dart
import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:digit/domain/helper/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BalanceCard extends StatefulWidget {
  final GetWalletModel? selectedWallet;

  const BalanceCard({
    super.key,
    required this.selectedWallet,
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _isBalanceVisible = false;

  @override
  Widget build(BuildContext context) {
    final wallet = widget.selectedWallet;
    if (wallet == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(AppDimensions.defaultMargin),
      padding: const EdgeInsets.all(AppDimensions.defaultMargin),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Dari",
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/Logo.svg',
                    height: AppDimensions.logoSize,
                    width: AppDimensions.logoSize,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    wallet.NamaWallet,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Saldo",
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isBalanceVisible
                          ? CurrencyFormat.convertToIdr(wallet.TotalSaldo, 2)
                          : "••••••••",
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    _isBalanceVisible ? 'assets/eye.svg' : 'assets/eye.svg',
                    height: AppDimensions.iconSize,
                    width: AppDimensions.iconSize,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
