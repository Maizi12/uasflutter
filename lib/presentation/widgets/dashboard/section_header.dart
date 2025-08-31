// lib/presentation/widgets/section_header.dart
import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: AppDimensions.defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          if (actionText != null && onActionTap != null)
            GestureDetector(
              onTap: onActionTap,
              child: Row(
                children: [
                  Text(
                    actionText!,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    "assets/arrow_forward.svg",
                    width: AppDimensions.iconSize,
                    height: AppDimensions.iconSize,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
