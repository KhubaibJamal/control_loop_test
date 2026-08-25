import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

class DetailHero extends StatelessWidget {
  final String image;
  final double height;
  final bool fullyBooked;

  const DetailHero({
    super.key,
    required this.image,
    required this.height,
    this.fullyBooked = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: .expand,
        children: [
          Image.asset(image, fit: .cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: .topCenter,
                end: .bottomCenter,
                colors: [
                  CustomColors.black.withValues(alpha: 0.55),
                  CustomColors.black.withValues(alpha: 0.1),
                  CustomColors.black.withValues(alpha: 0.45),
                ],
                stops: const [0, 0.4, 1],
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16.rw(context),
                8.rh(context),
                16.rw(context),
                0,
              ),
              child: Align(
                alignment: .topLeft,
                child: Material(
                  color: CustomColors.white,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => Navigator.pop(context),
                    child: SizedBox(
                      width: 40.rw(context),
                      height: 40.rh(context),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16.rf(context),
                        color: CustomColors.primaryTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (fullyBooked)
            Positioned(
              right: 12.rw(context),
              bottom: 12.rh(context),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.rw(context),
                  vertical: 5.rh(context),
                ),
                decoration: BoxDecoration(
                  color: CustomColors.badgeBg,
                  borderRadius: .circular(20),
                ),
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    Text(
                      Constants.fullyBooked,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14.rf(context),
                        color: CustomColors.primary,
                        fontFamily: Constants.fontFamily,
                      ),
                    ),
                    SizedBox(width: 6.rw(context)),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: CustomColors.primary.withValues(alpha: 0.3),
                        shape: .circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
