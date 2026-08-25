import 'package:control_loop_test/data/models/service_models.dart';
import 'package:control_loop_test/presentation/view/widgets/rating_badge.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/constants/media_constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProviderHomeCard extends StatelessWidget {
  final ProviderItem provider;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;

  const ProviderHomeCard({
    super.key,
    required this.provider,
    this.onTap,
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
          crossAxisAlignment: .start,
          children: [
            ClipRRect(
              borderRadius: .circular(4),
              child: Image.asset(
                provider.image,
                width: 90.rw(context),
                height: 89.rh(context),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.rw(context)),
            Expanded(
              child: SizedBox(
                height: 89.rh(context),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      provider.name,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                            fontSize: 18.rf(context),
                            fontWeight: .w600,
                            color: CustomColors.primaryTextColor,
                            fontFamily: Constants.fontFamily,
                          ),
                    ),
                    SizedBox(height: 4.rh(context)),
                    _DynamicTags(tags: provider.tags),
                    const Spacer(),
                    RatingBadge(rating: provider.rating.toStringAsFixed(1)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 89.rh(context),
              child: Align(
                alignment: .bottomCenter,
                child: GestureDetector(
                  onTap: onBookmark,
                  behavior: .opaque,
                  child: Padding(
                    padding: .only(left: 4.rw(context)),
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
                              .srcIn,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DynamicTags extends StatelessWidget {
  final List<String> tags;

  const _DynamicTags({required this.tags});

  double _measure(String text, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return painter.width;
  }

  Widget _dot(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 6.rw(context)),
      child: Container(
        width: 5,
        height: 5,
        decoration: const BoxDecoration(
          color: CustomColors.tagDot,
          shape: .circle,
        ),
      ),
    );
  }

  int _visibleCount({
    required double maxWidth,
    required TextStyle tagStyle,
    required TextStyle moreStyle,
    required double separator,
  }) {
    if (tags.isEmpty) return 0;
    if (tags.length == 1) return 1;

    const safety = 12.0;
    final limit = maxWidth - safety;

    for (var count = tags.length; count >= 1; count--) {
      var width = 0.0;
      for (var i = 0; i < count; i++) {
        if (i > 0) width += separator;
        width += _measure(tags[i], tagStyle);
      }
      final remaining = tags.length - count;
      if (remaining > 0) {
        width += separator + _measure('+$remaining more', moreStyle);
      }
      if (width <= limit) return count;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    final tagStyle = TextStyle(
      fontSize: 16.rf(context),
      fontWeight: .w400,
      letterSpacing: 0.5,
      height: 1.5,
      color: CustomColors.tagText,
      fontFamily: Constants.fontFamily,
    );
    final moreStyle = tagStyle.copyWith(color: CustomColors.tagMore);
    final separator = 5.0 + (6.rw(context) * 2);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final count = _visibleCount(
          maxWidth: maxWidth,
          tagStyle: tagStyle,
          moreStyle: moreStyle,
          separator: separator,
        );
        final visible = tags.take(count).toList();
        final remaining = tags.length - count;
        final needsEllipsis =
            count == 1 &&
            remaining > 0 &&
            (_measure(visible.first, tagStyle) +
                    separator +
                    _measure('+$remaining more', moreStyle)) >
                maxWidth - 12;

        return SizedBox(
          width: maxWidth,
          child: Row(
            children: [
              for (var i = 0; i < visible.length; i++) ...[
                if (i > 0) _dot(context),
                if (i == visible.length - 1 &&
                    (needsEllipsis || remaining == 0))
                  Flexible(
                    child: Text(
                      visible[i],
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: tagStyle,
                    ),
                  )
                else
                  Text(
                    visible[i],
                    maxLines: 1,
                    softWrap: false,
                    style: tagStyle,
                  ),
              ],
              if (remaining > 0) ...[
                _dot(context),
                Text(
                  '+$remaining more',
                  maxLines: 1,
                  softWrap: false,
                  style: moreStyle,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
