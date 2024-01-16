import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'core/routes.dart';
import 'core/themes/theme.dart';
import 'presentation/pages/analyze_skin/analyze_skin.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/main_page.dart';
import 'presentation/pages/onboarding/onboarding_page.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: ".env");

    cameras = await availableCameras();
  } on CameraException catch (e) {
    Logger().e('Error in fetching the cameras: $e');
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkinSavvy',
      theme: ThemeData(
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primaryColor),
        fontFamily: 'Poppins',
      ),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.onboarding: (context) => const OnboardingPage(),
        AppRoutes.analyzeSkin: (context) => AnalyzeSkinPage(camera: cameras[0]),
        AppRoutes.home: (context) => const MainPage(),
      },
    );
  }
}
