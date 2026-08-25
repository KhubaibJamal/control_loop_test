import '../../../res/theme/theme.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/provider_home_card.dart';
import '../widgets/section_header.dart';
import '../widgets/service_category_item.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/constants/demo_data.dart';
import 'package:control_loop_test/res/constants/media_constants.dart';
import 'package:control_loop_test/res/routes/routes.dart';
import '/utils/responsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entrance;
  late final Map<String, bool> _bookmarked;

  @override
  void initState() {
    super.initState();
    _bookmarked = {for (final p in DemoData.topProviders) p.id: p.bookmarked};
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  Animation<double> _fade(double start, double end) {
    return CurvedAnimation(
      parent: _entrance,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
  }

  void _dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    final searchBlock = 72.rh(context);
    final welcomeBlock = 168.rh(context);

    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Scaffold(
        backgroundColor: CustomColors.primaryScreenColor,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _HomeHeaderDelegate(
                topInset: topPad,
                welcomeHeight: welcomeBlock,
                searchHeight: searchBlock,
                welcomeBuilder: (context) => _welcomeContent(context),
                searchBuilder: (context) => _searchField(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16.rw(context),
                  24.rh(context),
                  16.rw(context),
                  0,
                ),
                child: FadeTransition(
                  opacity: _fade(0.25, 0.55),
                  child: SectionHeader(
                    title: Constants.services,
                    onSeeAll: () => _openCategory(context, 'Home cleaning'),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16.rw(context),
                  16.rh(context),
                  16.rw(context),
                  0,
                ),
                child: FadeTransition(
                  opacity: _fade(0.3, 0.65),
                  child: _servicesGrid(context),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16.rw(context),
                  28.rh(context),
                  16.rw(context),
                  0,
                ),
                child: FadeTransition(
                  opacity: _fade(0.4, 0.75),
                  child: SectionHeader(
                    title: Constants.topProviders,
                    onSeeAll: () => _openCategory(context, 'Home cleaning'),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                16.rw(context),
                16.rh(context),
                16.rw(context),
                24.rh(context),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final provider = DemoData.topProviders[index];
                  final start = (0.45 + index * 0.08).clamp(0.0, 0.8);
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.rh(context)),
                    child: FadeTransition(
                      opacity: _fade(start, 0.95),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.08),
                          end: Offset.zero,
                        ).animate(_fade(start, 0.95)),
                        child: ProviderHomeCard(
                          provider: provider.copyWith(
                            bookmarked: _bookmarked[provider.id] ?? false,
                          ),
                          onTap: () {
                            _dismissKeyboard();
                            Navigator.pushNamed(
                              context,
                              RouteNames.detailScreen,
                              arguments: provider,
                            );
                          },
                          onBookmark: () {
                            setState(() {
                              _bookmarked[provider.id] =
                                  !(_bookmarked[provider.id] ?? false);
                            });
                          },
                        ),
                      ),
                    ),
                  );
                }, childCount: DemoData.topProviders.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCategory(BuildContext context, String title) {
    _dismissKeyboard();
    Navigator.pushNamed(
      context,
      RouteNames.serviceCategoryScreen,
      arguments: title,
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

  Widget _servicesGrid(BuildContext context) {
    final services = DemoData.services;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: services.take(4).map((item) {
            return ServiceCategoryItem(
              item: item,
              onTap: () => _openCategory(
                context,
                item.title == 'Cleaning' ? 'Home cleaning' : item.title,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20.rh(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: services.skip(4).map((item) {
            return ServiceCategoryItem(
              item: item,
              onTap: () => _openCategory(context, item.title),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double topInset;
  final double welcomeHeight;
  final double searchHeight;
  final WidgetBuilder welcomeBuilder;
  final WidgetBuilder searchBuilder;

  _HomeHeaderDelegate({
    required this.topInset,
    required this.welcomeHeight,
    required this.searchHeight,
    required this.welcomeBuilder,
    required this.searchBuilder,
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
                              child: welcomeBuilder(context),
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
                        child: searchBuilder(context),
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

  @override
  bool shouldRebuild(covariant _HomeHeaderDelegate oldDelegate) {
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
