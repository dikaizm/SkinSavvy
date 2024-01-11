import 'package:flutter/material.dart';
import 'package:skinsavvy/presentation/widgets/button.dart';
import 'package:skinsavvy/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_skinsavvy.png',
                width: 250,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Gain your self-confident while maintaining environment',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'Find it here, join with us!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Button(
                label: 'Masuk',
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                }),
            const SizedBox(height: 16),
            Button(
              label: 'Sign in with Google',
              onPressed: () async {
                await AuthService().signInWithGoogle();
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
