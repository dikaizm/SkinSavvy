import 'package:flutter/material.dart';
import 'package:skinsavvy/presentation/widgets/button.dart';
import 'package:skinsavvy/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Set to false to make the screen full screen
      body: Container(
        padding: const EdgeInsets.only(top: 60),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_login.png'),
            fit: BoxFit.cover, // Set the image to cover the entire screen
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Image.asset(
                  'assets/images/logo_skinsavvy_monochrome.png',
                  height: 40,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 80, bottom: 60, left: 16, right: 16),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              )),
              child: Column(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Gain your self-confident while maintaining environment',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                            color: Colors.white,
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
                    },
                  ),
                  const SizedBox(height: 16),
                  Button(
                    label: 'Sign in with Google',
                    iconPath: 'assets/icons/ic_google.svg',
                    onPressed: () async {
                      await AuthService().signInWithGoogle();
                    },
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
