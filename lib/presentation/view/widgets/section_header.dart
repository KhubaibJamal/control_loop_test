import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: 18.rf(context),
              fontWeight: FontWeight.w600,
              color: CustomColors.primaryTextColor,
              fontFamily: Constants.fontFamily,
            ),
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              Constants.seeAll,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.rf(context),
                color: CustomColors.primary,
                fontFamily: Constants.fontFamily,
              ),
            ),
          ),
      ],
    );
  }
}
