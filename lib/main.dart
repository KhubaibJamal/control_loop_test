import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:control_loop_test/l10n/l10n.dart';
import 'package:control_loop_test/presentation/viewmodel/auth_viewmodel.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/routes/routes.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/service_locator.dart';
import 'package:control_loop_test/utils/utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthViewModel())],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: Utils.scaffoldMessengerKey,
          title: Constants.appName,
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: Routes.generateRoute,
          themeMode: ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
          locale: const Locale('en'),
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
