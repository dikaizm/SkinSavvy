import 'package:flutter/material.dart';
import 'package:skinsavvy/core/routes.dart';
import 'package:skinsavvy/presentation/widgets/button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Button(
            label: 'Logout',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.login);
            },
          )
        ],
      ),
    );
  }
}
