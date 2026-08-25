import 'package:control_loop_test/data/models/service_models.dart';
import 'package:control_loop_test/presentation/view/widgets/custom_button.dart';
import 'package:control_loop_test/presentation/view/widgets/rating_badge.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/constants/media_constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProviderListCard extends StatelessWidget {
  final ProviderItem provider;
  final VoidCallback? onTap;
  final VoidCallback? onBook;
  final VoidCallback? onBookmark;

  const ProviderListCard({
    super.key,
    required this.provider,
    this.onTap,
    this.onBook,
    this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.rw(context)),
        decoration: BoxDecoration(
          color: CustomColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: CustomColors.cardShadow,
              blurRadius: 48,
              spreadRadius: 3,
              offset: Offset(0, 16),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                provider.image,
                width: 90.rw(context),
                height: 89.rh(context),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.rw(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          provider.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontSize: 18.rf(context),
                            fontWeight: FontWeight.w600,
                            color: CustomColors.primaryTextColor,
                            fontFamily: Constants.fontFamily,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onBookmark,
                        behavior: HitTestBehavior.opaque,
                        child: SvgPicture.asset(
                          provider.bookmarked
                              ? MediaConstants.bookmarkFilledIcon
                              : MediaConstants.bookmarkOutlineIcon,
                          width: 24.rw(context),
                          height: 24.rh(context),
                          colorFilter: provider.bookmarked
                              ? null
                              : const ColorFilter.mode(
                                  CustomColors.bodyTextColor,
                                  BlendMode.srcIn,
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.rh(context)),
                  Row(
                    children: [
                      RatingBadge(rating: provider.rating.toStringAsFixed(1)),
                      SizedBox(width: 8.rw(context)),
                      Flexible(
                        child: Text(
                          provider.reviewsLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 13.rf(context),
                            color: CustomColors.tagText,
                            fontFamily: Constants.fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.rh(context)),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          provider.price,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 16.rf(context),
                            fontWeight: FontWeight.w600,
                            color: CustomColors.primaryTextColor,
                            fontFamily: Constants.fontFamily,
                          ),
                        ),
                      ),
                      CustomButton(
                        onPressed: onBook ?? () {},
                        buttonTitle: Constants.book,
                        height: 38.rh(context),
                        autoWidth: true,
                        radius: 30,
                        showElevation: false,
                        fontSize: 14,
                        textColor: CustomColors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.rw(context),
                          vertical: 6.rh(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
