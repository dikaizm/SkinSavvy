import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skinsavvy/core/themes/theme.dart';
import 'package:skinsavvy/presentation/pages/analyze_skin/analyze_skin.dart';
import 'package:skinsavvy/presentation/pages/auth/login_page.dart';
import 'package:skinsavvy/presentation/pages/main_page.dart';
import 'package:skinsavvy/presentation/pages/onboarding/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String analyzeSkin = '/analyze-skin';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkinSavvy',
      theme: ThemeData(
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Plus Jakarta Sans',
      ),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.onboarding: (context) => const OnboardingPage(),
        AppRoutes.analyzeSkin: (context) => const AnalyzeSkinPage(),
        AppRoutes.home: (context) => const MainPage(),
      },
    );
  }
}
