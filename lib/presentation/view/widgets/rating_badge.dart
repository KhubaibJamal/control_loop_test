import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

class RatingBadge extends StatelessWidget {
  final String rating;

  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28.rh(context),
      padding: EdgeInsets.symmetric(
        horizontal: 8.rw(context),
        vertical: 4.rh(context),
      ),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: CustomColors.lightBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 14, color: CustomColors.star),
          SizedBox(width: 4.rw(context)),
          Text(
            rating,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.4,
              color: CustomColors.primaryTextColor,
              fontFamily: Constants.fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
