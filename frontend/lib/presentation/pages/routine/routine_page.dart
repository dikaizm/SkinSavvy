import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skinsavvy/core/routes.dart';
import 'package:skinsavvy/core/themes/theme.dart';
import 'package:skinsavvy/presentation/widgets/app_bar.dart';
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
            _scheduleBannerSection(),
            const SizedBox(height: 16),
            _calendarSection(),
          ],
        ),
      ),
    );
  }

  GestureDetector _scheduleBannerSection() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.schedule);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppTheme.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
                child: Text(
              'Your Skincare Routine Schedule',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            )),
            const SizedBox(width: 16),
            Expanded(
              child: Image.asset(
                'assets/images/routine/schedule_banner.png',
              ),
            ),
            const SizedBox(width: 16),
            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              width: 32,
              height: 32,
            )
          ],
        ),
      ),
    );
  }

  Container _calendarSection() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: TableCalendar(
        focusedDay: todayDate,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        availableGestures: AvailableGestures.all,
        onDaySelected: _onDaySelected,
        selectedDayPredicate: (day) {
          return isSameDay(todayDate, day);
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: const TextStyle(color: Colors.white),
          todayTextStyle: const TextStyle(color: Colors.white),
          weekendTextStyle: const TextStyle(color: Colors.black),
          outsideTextStyle: const TextStyle(color: Colors.black),
          outsideDaysVisible: false,
        ),
      ),
    );
  }

  void _onDaySelected(selectedDay, focusedDay) {
    setState(() {
      todayDate = selectedDay;
    });
  }
}
