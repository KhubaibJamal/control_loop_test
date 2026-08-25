import 'package:control_loop_test/res/constants/media_constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CircleBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColors.bodyGrey,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap ?? () => Navigator.pop(context),
        child: SizedBox(
          width: 40.rw(context),
          height: 40.rh(context),
          child: Center(
            child: SvgPicture.asset(
              MediaConstants.arrowLeftIcon,
              width: 16.rw(context),
              height: 16.rh(context),
            ),
          ),
        ),
      ),
    );
  }
}
