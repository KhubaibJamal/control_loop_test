import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

class ServiceChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const ServiceChip({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 16.rw(context),
          vertical: 8.rh(context),
        ),
        decoration: BoxDecoration(
          color: isSelected ? CustomColors.primary : CustomColors.white,
          borderRadius: .circular(30),
          border: Border.all(
            color: CustomColors.primary.withValues(alpha: isSelected ? 1 : 0.3),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 14.rf(context),
            color: isSelected ? CustomColors.white : CustomColors.primary,
            fontFamily: Constants.fontFamily,
          ),
        ),
      ),
    );
  }
}
