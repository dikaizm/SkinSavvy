import 'package:flutter/material.dart';

import '../../core/themes/theme.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: const Text(
          'Scan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ScanCard(
              onTap: () {},
              title: 'Scan my face',
              imagePath: 'assets/images/scan/face.png',
            ),
            const SizedBox(height: 16),
            _ScanCard(
              onTap: () {},
              title: 'Scan a product\'s ingredients',
              imagePath: 'assets/images/scan/ingredients.png',
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanCard extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final String imagePath;

  const _ScanCard({
    required this.onTap,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.linen,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        splashColor: AppTheme.primaryColor.withOpacity(0.8),
        overlayColor: MaterialStateProperty.all(
          AppTheme.primaryColor.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Image.asset(imagePath, height: 150),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
