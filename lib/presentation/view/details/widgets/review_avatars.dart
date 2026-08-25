import 'package:control_loop_test/res/constants/media_constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

class ReviewAvatars extends StatelessWidget {
  const ReviewAvatars({super.key});

  static const _images = [
    MediaConstants.providerList2,
    MediaConstants.providerList3,
    MediaConstants.providerList5,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 116.rw(context),
      height: 32.rh(context),
      child: Stack(
        alignment: .centerLeft,
        children: [
          ...List.generate(3, (i) {
            return Positioned(
              left: (i * 22).rw(context),
              top: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 16.rw(context),
                backgroundColor: CustomColors.bodyGrey,
                backgroundImage: AssetImage(_images[i]),
              ),
            );
          }),
          Positioned(
            left: 66.rw(context),
            top: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: 16.rw(context),
              backgroundColor: CustomColors.bodyGrey,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12.rf(context),
                color: CustomColors.primaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
