import 'package:control_loop_test/data/models/service_models.dart';
import 'package:control_loop_test/presentation/view/details/widgets/detail_hero.dart';
import 'package:control_loop_test/presentation/view/details/widgets/detail_sticky_bar.dart';
import 'package:control_loop_test/presentation/view/details/widgets/gallery_section.dart';
import 'package:control_loop_test/presentation/view/details/widgets/outline_card.dart';
import 'package:control_loop_test/presentation/view/details/widgets/review_avatars.dart';
import 'package:control_loop_test/presentation/view/details/widgets/service_chip.dart';
import 'package:control_loop_test/presentation/view/details/widgets/stats_card.dart';
import 'package:control_loop_test/presentation/view/widgets/rating_badge.dart';
import 'package:control_loop_test/presentation/view/widgets/section_header.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/constants/demo_data.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final ProviderItem provider;

  const DetailScreen({super.key, required this.provider});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectedChip = 0;
  bool _expandedAbout = false;
  bool _showSticky = false;

  late final ProviderItem provider = DemoData.detailFor(widget.provider);
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final show = _scrollController.offset > 200;
    if (show != _showSticky) setState(() => _showSticky = show);
  }

  @override
  Widget build(BuildContext context) {
    final heroHeight = 156.rh(context);
    final avatarSize = 96.rw(context);

    return Scaffold(
      backgroundColor: CustomColors.white,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: heroHeight + avatarSize / 2,
                      child: Stack(
                        clipBehavior: .none,
                        children: [
                          DetailHero(
                            image: provider.resolvedHero,
                            height: heroHeight,
                            fullyBooked: provider.fullyBooked,
                          ),
                          Positioned(
                            top: heroHeight - avatarSize / 2,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: ClipOval(
                                child: Image.asset(
                                  provider.image,
                                  width: avatarSize,
                                  height: avatarSize,
                                  fit: .cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.rh(context)),
                    Text(
                      provider.name,
                      textAlign: .center,
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(
                            fontSize: 20.rf(context),
                            fontWeight: .w600,
                            color: CustomColors.primaryTextColor,
                            fontFamily: Constants.fontFamily,
                          ),
                    ),
                    SizedBox(height: 8.rh(context)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.rw(context)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 14,
                                color: CustomColors.primary,
                              ),
                              SizedBox(width: 4.rw(context)),
                              Text(
                                Constants.officeAddress,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontSize: 14.rf(context),
                                      color: CustomColors.primary,
                                      fontFamily: Constants.fontFamily,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.rh(context)),
                          Text(
                            provider.address,
                            textAlign: .center,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontSize: 14.rf(context),
                                  color: CustomColors.primaryTextColor,
                                  fontFamily: Constants.fontFamily,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.rh(context)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.rw(context)),
                      child: SizedBox(
                        height: 58.rh(context),
                        child: Row(
                          children: [
                            Expanded(
                              child: StatsCard(
                                title: provider.rating.toStringAsFixed(1),
                                label: Constants.overallRating,
                                isRating: true,
                              ),
                            ),
                            SizedBox(width: 8.rw(context)),
                            Expanded(
                              child: StatsCard(
                                title: provider.totalBookings,
                                label: Constants.totalBookings,
                              ),
                            ),
                            SizedBox(width: 8.rw(context)),
                            Expanded(
                              child: StatsCard(
                                title: provider.servicesCount,
                                label: Constants.servicesOffered,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  16.rw(context),
                  20.rh(context),
                  16.rw(context),
                  24.rh(context),
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(Constants.aboutMe, style: _sectionTitle(context)),
                    SizedBox(height: 8.rh(context)),
                    GestureDetector(
                      onTap: () =>
                          setState(() => _expandedAbout = !_expandedAbout),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: provider.about,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontSize: 14.rf(context),
                                    color: CustomColors.secondaryTextColor,
                                    height: 1.5,
                                    fontFamily: Constants.fontFamily,
                                  ),
                            ),
                            if (!_expandedAbout)
                              TextSpan(
                                text: ' ${Constants.readMore}',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontSize: 14.rf(context),
                                      color: CustomColors.primary,
                                      fontWeight: .w600,
                                      fontFamily: Constants.fontFamily,
                                    ),
                              ),
                          ],
                        ),
                        maxLines: _expandedAbout ? null : 3,
                        overflow: _expandedAbout ? .visible : .ellipsis,
                      ),
                    ),
                    SizedBox(height: 20.rh(context)),
                    Text(Constants.services, style: _sectionTitle(context)),
                    SizedBox(height: 12.rh(context)),
                    Wrap(
                      spacing: 8.rw(context),
                      runSpacing: 8.rh(context),
                      children: List.generate(provider.serviceChips.length, (
                        index,
                      ) {
                        return ServiceChip(
                          title: provider.serviceChips[index],
                          isSelected: index == _selectedChip,
                          onTap: () => setState(() => _selectedChip = index),
                        );
                      }),
                    ),
                    SizedBox(height: 12.rh(context)),
                    Text(
                      provider.about,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14.rf(context),
                        color: CustomColors.secondaryTextColor,
                        height: 1.5,
                        fontFamily: Constants.fontFamily,
                      ),
                    ),
                    SizedBox(height: 16.rh(context)),
                    OutlineCard(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            Constants.noOfStaffs,
                            style: _sectionTitle(context),
                          ),
                          SizedBox(height: 8.rh(context)),
                          Text(
                            provider.staffCount,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontSize: 14.rf(context),
                                  color: CustomColors.primaryTextColor,
                                  fontFamily: Constants.fontFamily,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.rh(context)),
                    OutlineCard(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            Constants.reviews,
                            style: _sectionTitle(context),
                          ),
                          SizedBox(height: 10.rh(context)),
                          Row(
                            children: [
                              RatingBadge(
                                rating: provider.rating.toStringAsFixed(1),
                              ),
                              SizedBox(width: 8.rw(context)),
                              Expanded(
                                child: Text(
                                  provider.reviewsLabel,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        fontSize: 14.rf(context),
                                        color: CustomColors.primaryTextColor,
                                        fontFamily: Constants.fontFamily,
                                      ),
                                ),
                              ),
                              const ReviewAvatars(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.rh(context)),
                    SectionHeader(
                      title: Constants.photosVideos,
                      onSeeAll: () {},
                    ),
                    SizedBox(height: 12.rh(context)),
                    GallerySection(images: provider.gallery),
                    SizedBox(height: 20.rh(context)),
                    SectionHeader(
                      title: Constants.certification,
                      onSeeAll: () {},
                    ),
                    SizedBox(height: 12.rh(context)),
                    GallerySection(images: provider.certifications),
                  ]),
                ),
              ),
            ],
          ),
          if (_showSticky) DetailStickyBar(title: provider.name),
        ],
      ),
    );
  }

  TextStyle _sectionTitle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontSize: 16.rf(context),
      fontWeight: .w600,
      color: CustomColors.primaryTextColor,
      fontFamily: Constants.fontFamily,
    );
  }
}
