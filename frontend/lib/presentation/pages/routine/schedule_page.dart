import 'package:flutter/material.dart';
import 'package:skinsavvy/core/themes/theme.dart';
import 'package:skinsavvy/presentation/pages/routine/models/schedule_model.dart';
import 'package:skinsavvy/presentation/widgets/app_bar.dart';
import 'package:skinsavvy/presentation/widgets/card_period_schedule.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  ScheduleDetail schedules = ScheduleModel.getSchedule().details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Your Skincare Schedule', 16, true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CardPeriodSchedule(
              products: schedules.morning,
              title: 'Morning, Nadya!',
              color: AppTheme.primaryColor.withOpacity(0.5),
              iconPath: 'assets/images/routine/schedule_morning.png'),
          const SizedBox(
            height: 16,
          ),
          CardPeriodSchedule(
              products: schedules.afternoon,
              title: 'Afternoon, Nadya!',
              color: AppTheme.secondaryColor.withOpacity(0.7),
              iconPath: 'assets/images/routine/schedule_afternoon.png'),
          const SizedBox(
            height: 16,
          ),
          CardPeriodSchedule(
              products: schedules.night,
              title: 'Night, Nadya!',
              color: AppTheme.dartTeal,
              textColor: Colors.white,
              iconPath: 'assets/images/routine/schedule_night.png'),
        ],
      ),
    );
  }
}
