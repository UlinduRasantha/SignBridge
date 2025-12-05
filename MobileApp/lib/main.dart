// File: lib/main.dart
import 'package:flutter/material.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp_project/l10n/app_localizations.dart';
import 'package:fyp_project/screens/splash_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Load saved language preference
  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('language_code') ?? 'en';

  runApp(MyApp(Locale(langCode)));
}

class MyApp extends StatefulWidget {
  final Locale initialLocale;
  const MyApp(this.initialLocale, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  // Function to change language and persist choice
  Future<void> _changeLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Language Translator',
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('si'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      fallbackLocale: const Locale('en'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
