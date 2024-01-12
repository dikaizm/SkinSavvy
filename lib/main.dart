import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skinsavvy/core/routes.dart';
import 'package:skinsavvy/core/themes/theme.dart';
import 'package:skinsavvy/presentation/pages/analyze_skin/analyze_skin.dart';
import 'package:skinsavvy/presentation/pages/auth/login_page.dart';
import 'package:skinsavvy/presentation/pages/main_page.dart';
import 'package:skinsavvy/presentation/pages/onboarding/onboarding_page.dart';
import 'package:skinsavvy/presentation/pages/skincare_rec/skincare_rec_page.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: ".env");

    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }

  runApp(const ProviderScope(child: MyApp()));
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
        fontFamily: 'Poppins',
      ),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.onboarding: (context) => const OnboardingPage(),
        AppRoutes.analyzeSkin: (context) => AnalyzeSkinPage(
              camera: cameras[0],
            ),
        AppRoutes.home: (context) => const MainPage(),
      },
    );
  }
}
