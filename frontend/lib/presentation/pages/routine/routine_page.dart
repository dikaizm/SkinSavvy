import 'package:flutter/material.dart';
import 'package:skinsavvy/core/routes.dart';
import 'package:skinsavvy/presentation/widgets/app_bar.dart';
import 'package:skinsavvy/presentation/widgets/button.dart';
import 'package:table_calendar/table_calendar.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  DateTime todayDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Skincare Routine', 16),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: Text('Routine'),
            ),
            TableCalendar(
                focusedDay: todayDate,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14)),
            Button(
              label: 'Schedule',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.schedule);
              },
            ),
          ],
        ),
      ),
    );
  }
}
