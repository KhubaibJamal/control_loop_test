import 'package:control_loop_test/data/models/service_models.dart';
import 'package:control_loop_test/presentation/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:control_loop_test/presentation/view/details/detail_screen.dart';
import 'package:control_loop_test/presentation/view/services/service_category_screen.dart';
import 'package:control_loop_test/res/constants/demo_data.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static const String bottomNavBar = 'bottom_nav_bar';
  static const String serviceCategoryScreen = 'service_category_screen';
  static const String detailScreen = 'detail_screen';
}

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.bottomNavBar:
        final index = routeSettings.arguments is int
            ? routeSettings.arguments as int
            : 0;
        return _fadeSlide(BottomNavBar(index: index), routeSettings);
      case RouteNames.serviceCategoryScreen:
        final title = routeSettings.arguments is String
            ? routeSettings.arguments as String
            : 'Home cleaning';
        return _fadeSlide(ServiceCategoryScreen(title: title), routeSettings);
      case RouteNames.detailScreen:
        final provider = routeSettings.arguments is ProviderItem
            ? routeSettings.arguments as ProviderItem
            : DemoData.topProviders.first;
        return _fadeSlide(DetailScreen(provider: provider), routeSettings);
      default:
        return MaterialPageRoute(
          builder: (_) => const Center(child: Text('No Route Defined')),
        );
    }
  }

  static PageRouteBuilder _fadeSlide(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.04, 0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
