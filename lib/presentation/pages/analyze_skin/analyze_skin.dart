import 'package:flutter/material.dart';

class AnalyzeSkinPage extends StatefulWidget {
  const AnalyzeSkinPage({super.key});

  @override
  State<StatefulWidget> createState() => _AnalyzeSkinPageState();
}

class _AnalyzeSkinPageState extends State<AnalyzeSkinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Analyze Skin'),
        ),
        body: const Center(
          child: Text('Analyze Skin Page'),
        ));
  }
}
