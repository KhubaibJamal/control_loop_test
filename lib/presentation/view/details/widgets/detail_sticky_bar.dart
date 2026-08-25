import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

class DetailStickyBar extends StatelessWidget {
  final String title;

  const DetailStickyBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColors.white,
      elevation: 2,
      shadowColor: CustomColors.black.withValues(alpha: 0.1),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 52.rh(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.rw(context)),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16.rf(context),
                    color: CustomColors.primaryTextColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    textAlign: .center,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 16.rf(context),
                      fontWeight: .w600,
                      color: CustomColors.primaryTextColor,
                      fontFamily: Constants.fontFamily,
                    ),
                  ),
                ),
                SizedBox(width: 48.rw(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
