import 'package:flutter/material.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:lottie/lottie.dart';

enum MessageType {
  success(CustomColors.primaryTextColor),
  warning(CustomColors.warningMessageColor),
  error(CustomColors.errorMessageColor);

  final Color value;
  const MessageType(this.value);
}

class Utils {
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // Getter to access the global key
  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;

  static Widget progress({
    double? width,
    double? height,
    Color? normalProgressColor,
    bool? showWhite,
  }) {
    if (Constants.useLottieProgress) {
      return LottieBuilder.asset(
        'assets/lottie/${showWhite == true ? Constants.progressLottieFileWhite : Constants.progressLottieFile}',
        width: width ?? 45,
        height: height ?? 45,
        delegates: LottieDelegates(
          values: [
            ValueDelegate.color([
              'Layer 5 Outlines',
              'Group 1',
              '**',
            ], value: CustomColors.white),
            ValueDelegate.color([
              'cube 4 Outlines',
              'Group 1',
              '**',
            ], value: CustomColors.white),
            ValueDelegate.color([
              'cube 2 Outlines',
              'Group 1',
              '**',
            ], value: Colors.grey.shade100),
            ValueDelegate.color([
              'cube 3 Outlines',
              'Group 1',
              '**',
            ], value: Colors.grey.shade100),
          ],
        ),
      );
    } else {
      return CircularProgressIndicator(color: normalProgressColor);
    }
  }
}
