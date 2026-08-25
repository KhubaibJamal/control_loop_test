import 'package:control_loop_test/data/models/service_models.dart';
import 'package:control_loop_test/presentation/view/widgets/rating_badge.dart';
import 'package:control_loop_test/presentation/view/widgets/section_header.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/constants/demo_data.dart';
import 'package:control_loop_test/res/constants/media_constants.dart';
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

  late final ProviderItem provider = DemoData.detailFor(widget.provider);

  @override
  Widget build(BuildContext context) {
    final heroHeight = 156.rh(context);
    final avatarSize = 96.rw(context);

    return Scaffold(
      backgroundColor: CustomColors.white,
      body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        height: heroHeight + avatarSize / 2,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            _hero(context, heroHeight),
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
                                    fit: BoxFit.cover,
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
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(
                              fontSize: 20.rf(context),
                              fontWeight: FontWeight.w600,
                              color: CustomColors.primaryTextColor,
                              fontFamily: Constants.fontFamily,
                            ),
                      ),
                      SizedBox(height: 8.rh(context)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.rw(context),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                              textAlign: TextAlign.center,
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.rw(context),
                        ),
                        child: SizedBox(
                          height: 58.rh(context),
                          child: Row(
                            children: [
                              Expanded(
                                child: _statCard(
                                  context,
                                  top: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        size: 14,
                                        color: CustomColors.star,
                                      ),
                                      SizedBox(width: 2.rw(context)),
                                      Text(
                                        provider.rating.toStringAsFixed(1),
                                        style: _statValueStyle(context),
                                      ),
                                    ],
                                  ),
                                  label: Constants.overallRating,
                                ),
                              ),
                              SizedBox(width: 8.rw(context)),
                              Expanded(
                                child: _statCard(
                                  context,
                                  top: Text(
                                    provider.totalBookings,
                                    style: _statValueStyle(context),
                                  ),
                                  label: Constants.totalBookings,
                                ),
                              ),
                              SizedBox(width: 8.rw(context)),
                              Expanded(
                                child: _statCard(
                                  context,
                                  top: Text(
                                    provider.servicesCount,
                                    style: _statValueStyle(context),
                                  ),
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
                                        fontWeight: FontWeight.w600,
                                        fontFamily: Constants.fontFamily,
                                      ),
                                ),
                            ],
                          ),
                          maxLines: _expandedAbout ? null : 3,
                          overflow: _expandedAbout
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
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
                          final selected = index == _selectedChip;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedChip = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.rw(context),
                                vertical: 8.rh(context),
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? CustomColors.primary
                                    : CustomColors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: CustomColors.primary.withValues(
                                    alpha: selected ? 1 : 0.3,
                                  ),
                                ),
                              ),
                              child: Text(
                                provider.serviceChips[index],
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontSize: 14.rf(context),
                                      color: selected
                                          ? CustomColors.white
                                          : CustomColors.primary,
                                      fontFamily: Constants.fontFamily,
                                    ),
                              ),
                            ),
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
                      _outlinedCard(
                        context,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                      _outlinedCard(
                        context,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Constants.reviews,
                              style: _sectionTitle(context),
                            ),
                            SizedBox(height: 10.rh(context)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RatingBadge(
                                  rating: provider.rating.toStringAsFixed(1),
                                ),
                                SizedBox(width: 8.rw(context)),
                                Expanded(
                                  child: Text(
                                    provider.reviewsLabel,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 14.rf(context),
                                          color: CustomColors.primaryTextColor,
                                          fontFamily: Constants.fontFamily,
                                        ),
                                  ),
                                ),
                                _reviewAvatars(context),
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
                      _galleryRow(context),
                      SizedBox(height: 20.rh(context)),
                      SectionHeader(
                        title: Constants.certification,
                        onSeeAll: () {},
                      ),
                      SizedBox(height: 12.rh(context)),
                      _certsRow(context),
                    ]),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _hero(BuildContext context, double height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(provider.resolvedHero, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
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
                alignment: Alignment.topLeft,
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
          if (provider.fullyBooked)
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                        shape: BoxShape.circle,
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

  Widget _reviewAvatars(BuildContext context) {
    const images = [
      MediaConstants.providerList2,
      MediaConstants.providerList3,
      MediaConstants.providerList5,
    ];
    return SizedBox(
      width: 116.rw(context),
      height: 32.rh(context),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ...List.generate(3, (i) {
            return Positioned(
              left: (i * 22).rw(context),
              top: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 16.rw(context),
                backgroundColor: CustomColors.bodyGrey,
                backgroundImage: AssetImage(images[i]),
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

  Widget _galleryRow(BuildContext context) {
    final items = provider.gallery;
    return Row(
      children: List.generate(items.length, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index == items.length - 1 ? 0 : 12.rw(context),
            ),
            child: GestureDetector(
              onTap: () => _openGallery(context, index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 112 / 92,
                  child: Image.asset(items[index], fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _certsRow(BuildContext context) {
    final items = provider.certifications;
    return Row(
      children: List.generate(items.length, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index == items.length - 1 ? 0 : 12.rw(context),
            ),
            child: GestureDetector(
              onTap: () => _openGallery(context, index, images: items),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 112 / 92,
                  child: Image.asset(items[index], fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _openGallery(BuildContext context, int index, {List<String>? images}) {
    final list = images ?? provider.gallery;
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: CustomColors.black.withValues(alpha: 0.92),
        pageBuilder: (_, __, ___) =>
            _MediaViewer(images: list, initialIndex: index),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Widget _statCard(
    BuildContext context, {
    required Widget top,
    required String label,
  }) {
    return Container(
      height: 58.rh(context),
      padding: EdgeInsets.symmetric(horizontal: 4.rw(context)),
      decoration: BoxDecoration(
        color: CustomColors.statCardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CustomColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          top,
          SizedBox(height: 4.rh(context)),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 12,
              color: CustomColors.secondaryTextColor,
              fontFamily: Constants.fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  Widget _outlinedCard(BuildContext context, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.rw(context)),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CustomColors.borderColor),
      ),
      child: child,
    );
  }

  TextStyle _sectionTitle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontSize: 16.rf(context),
      fontWeight: FontWeight.w600,
      color: CustomColors.primaryTextColor,
      fontFamily: Constants.fontFamily,
    );
  }

  TextStyle _statValueStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: CustomColors.primaryTextColor,
      fontFamily: Constants.fontFamily,
    );
  }
}

class _MediaViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _MediaViewer({required this.images, required this.initialIndex});

  @override
  State<_MediaViewer> createState() => _MediaViewerState();
}

class _MediaViewerState extends State<_MediaViewer> {
  late final PageController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: (value) => setState(() => _index = value),
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  child: Center(
                    child: Image.asset(
                      widget.images[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Text(
                '${_index + 1}/${widget.images.length}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
