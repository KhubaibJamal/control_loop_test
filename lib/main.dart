import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/routes/routes.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/service_locator.dart';
import 'package:control_loop_test/utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    ServiceLocator.setContext(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Utils.scaffoldMessengerKey,
        title: Constants.appName,
        initialRoute: RouteNames.bottomNavBar,
        onGenerateRoute: Routes.generateRoute,
        themeMode: ThemeMode.light,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
