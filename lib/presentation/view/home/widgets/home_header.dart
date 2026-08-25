import 'package:control_loop_test/presentation/view/widgets/custom_text_form_field.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/constants/demo_data.dart';
import 'package:control_loop_test/res/constants/media_constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double topInset;
  final double welcomeHeight;
  final double searchHeight;

  HomeHeaderDelegate({
    required this.topInset,
    required this.welcomeHeight,
    required this.searchHeight,
  });

  @override
  double get maxExtent => topInset + welcomeHeight + searchHeight;

  @override
  double get minExtent => topInset + searchHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final collapseRange = (maxExtent - minExtent).clamp(1.0, double.infinity);
    final progress = (shrinkOffset / collapseRange).clamp(0.0, 1.0);
    final welcomeOpacity = (1 - progress * 1.4).clamp(0.0, 1.0);

    return Material(
      color: CustomColors.primary,
      elevation: progress > 0.05 ? 3 : 0,
      shadowColor: CustomColors.black.withValues(alpha: 0.15),
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: FractionallySizedBox(
                  alignment: Alignment.topRight,
                  widthFactor: 234.19 / 393,
                  heightFactor: 269 / 290,
                  child: CustomPaint(painter: _HeaderBentShapePainter()),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: topInset),
              child: Column(
                children: [
                  if (welcomeOpacity > 0)
                    Opacity(
                      opacity: welcomeOpacity,
                      child: SizedBox(
                        height: welcomeHeight * (1 - progress),
                        child: ClipRect(
                          child: OverflowBox(
                            alignment: Alignment.topCenter,
                            maxHeight: welcomeHeight,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                16.rw(context),
                                12.rh(context),
                                16.rw(context),
                                0,
                              ),
                              child: _welcomeContent(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        16.rw(context),
                        8.rh(context),
                        16.rw(context),
                        16.rh(context),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: _searchField(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _welcomeContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.asset(
                MediaConstants.avatarUser,
                width: 56.rw(context),
                height: 56.rh(context),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.rw(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Constants.welcome,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: CustomColors.white,
                      fontSize: 18.rf(context),
                      fontWeight: FontWeight.w500,
                      fontFamily: Constants.fontFamily,
                    ),
                  ),
                  SizedBox(height: 2.rh(context)),
                  Text(
                    '${DemoData.userName} 👋',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: CustomColors.lightBorder,
                      fontSize: 16.rf(context),
                      fontFamily: Constants.fontFamily,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 56.rw(context),
              height: 56.rw(context),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 56.rw(context),
                    height: 56.rw(context),
                    decoration: const BoxDecoration(
                      color: CustomColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 24.rw(context),
                    height: 24.rw(context),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(
                          MediaConstants.notificationIcon,
                          width: 24.rw(context),
                          height: 24.rw(context),
                        ),
                        Positioned(
                          top: 2.rw(context),
                          right: 4.rw(context),
                          child: Container(
                            width: 6.rw(context),
                            height: 6.rw(context),
                            decoration: const BoxDecoration(
                              color: CustomColors.notificationDot,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.rh(context)),
        SizedBox(
          width: 200.rw(context),
          child: Text(
            Constants.whatService,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: CustomColors.white,
              fontSize: 24.rf(context),
              fontWeight: FontWeight.w600,
              height: 1.4,
              fontFamily: Constants.fontFamily,
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchField(BuildContext context) {
    return CustomTextFormField(
      hintText: Constants.searchServicesHint,
      fillColor: CustomColors.white,
      dense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 4.rw(context),
        vertical: 12.rh(context),
      ),
      prefixContainer: Icon(
        Icons.search_rounded,
        color: CustomColors.textFieldHintColor,
        size: 20.rf(context),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant HomeHeaderDelegate oldDelegate) {
    return oldDelegate.topInset != topInset ||
        oldDelegate.welcomeHeight != welcomeHeight ||
        oldDelegate.searchHeight != searchHeight;
  }
}

class _HeaderBentShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.064, size.height * 0.347)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(
      path,
      Paint()
        ..color = CustomColors.headerShape
        ..style = PaintingStyle.fill
        ..isAntiAlias = true,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
