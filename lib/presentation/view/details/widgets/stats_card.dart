import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String label;
  final bool isRating;

  const StatsCard({
    super.key,
    required this.title,
    required this.label,
    this.isRating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58.rh(context),
      padding: EdgeInsets.symmetric(horizontal: 4.rw(context)),
      decoration: BoxDecoration(
        color: CustomColors.statCardBg,
        borderRadius: .circular(8),
        border: Border.all(color: CustomColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Row(
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              if (isRating) ...[
                const Icon(Icons.star_rounded, size: 14, color: CustomColors.star),
                SizedBox(width: 2.rw(context)),
              ],
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: .w600,
                  color: CustomColors.primaryTextColor,
                  fontFamily: Constants.fontFamily,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.rh(context)),
          Text(
            label,
            textAlign: .center,
            maxLines: 1,
            overflow: .ellipsis,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 12,
              color: CustomColors.secondaryTextColor,
              fontFamily: Constants.fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
