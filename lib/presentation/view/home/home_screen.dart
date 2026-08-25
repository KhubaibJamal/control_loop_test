import 'package:control_loop_test/presentation/view/home/widgets/home_header.dart';
import 'package:control_loop_test/presentation/view/home/widgets/provider_home_card.dart';
import 'package:control_loop_test/presentation/view/home/widgets/services_home_section.dart';
import 'package:control_loop_test/presentation/view/widgets/section_header.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/constants/demo_data.dart';
import 'package:control_loop_test/res/routes/routes.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

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
              delegate: HomeHeaderDelegate(
                topInset: topPad,
                welcomeHeight: 168.rh(context),
                searchHeight: 72.rh(context),
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
                  child: const ServicesHomeSection(),
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
}
