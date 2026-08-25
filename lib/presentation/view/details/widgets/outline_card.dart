import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

class OutlineCard extends StatelessWidget {
  final Widget child;

  const OutlineCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.rw(context)),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: .circular(8),
        border: Border.all(color: CustomColors.borderColor),
      ),
      child: child,
    );
  }
}
