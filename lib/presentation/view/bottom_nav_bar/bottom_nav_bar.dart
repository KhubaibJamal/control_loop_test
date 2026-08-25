import 'package:control_loop_test/presentation/view/home/home_screen.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../../utils/responsiveSize.dart';

class BottomNavBar extends StatefulWidget {
  final int? index;

  const BottomNavBar({super.key, this.index});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int currentIndex;
  late PageController _pageController;

  final List<Widget> screens = const [
    HomeScreen(),
    Scaffold(body: Center(child: Text(Constants.bookings))),
    Scaffold(body: Center(child: Text(Constants.chats))),
    Scaffold(body: Center(child: Text(Constants.profile))),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index ?? 0;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    if (index == currentIndex) return;
    setState(() => currentIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_outlined, Icons.home_rounded, Constants.home),
      (Icons.assignment_outlined, Icons.assignment, Constants.bookings),
      (
        Icons.chat_bubble_outline_rounded,
        Icons.chat_bubble_rounded,
        Constants.chats,
      ),
      (Icons.person_outline_rounded, Icons.person_rounded, Constants.profile),
    ];

    return Scaffold(
      backgroundColor: CustomColors.primaryScreenColor,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: CustomColors.navBarColor,
          boxShadow: [
            BoxShadow(
              color: CustomColors.primaryTextColor.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              12.rw(context),
              8.rh(context),
              12.rw(context),
              8.rh(context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(screens.length, (index) {
                final selected = index == currentIndex;
                return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _onTabSelected(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      padding: EdgeInsets.symmetric(vertical: 4.rh(context)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedScale(
                            scale: selected ? 1.08 : 1,
                            duration: const Duration(milliseconds: 220),
                            child: Icon(
                              selected ? items[index].$2 : items[index].$1,
                              size: 24,
                              color: selected
                                  ? CustomColors.primary
                                  : CustomColors.bodyTextColor,
                            ),
                          ),
                          SizedBox(height: 2.rh(context)),
                          Text(
                            items[index].$3,
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(
                                  color: selected
                                      ? CustomColors.primary
                                      : CustomColors.bodyTextColor,
                                  fontSize: 13.rf(context),
                                  fontWeight: selected
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                                  fontFamily: Constants.fontFamily,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
