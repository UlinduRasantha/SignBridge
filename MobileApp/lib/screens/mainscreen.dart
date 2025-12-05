import 'package:flutter/material.dart';
import 'package:fyp_project/l10n/app_localizations.dart';
import 'package:fyp_project/widgets/navigation.dart';
import 'package:fyp_project/screens/home_screen.dart';
import 'package:fyp_project/screens/settings_screen.dart';
import 'package:fyp_project/screens/user_guide_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Mainscreen extends StatelessWidget {
  Mainscreen({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          return Navigation(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: '/user-guide',
            builder: (context, state) => const UserGuideScreen(),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Sign Language Translator',

      // ✅ Add localization support
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('si'),
      ],
    );
  }
}
