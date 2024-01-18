import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skinsavvy/core/content.dart';
import 'package:skinsavvy/core/routes.dart';
import 'package:skinsavvy/core/themes/theme.dart';
import 'package:skinsavvy/presentation/pages/routine/models/filter_calendar_model.dart';
import 'package:skinsavvy/presentation/pages/routine/models/routine_model.dart';
import 'package:skinsavvy/presentation/pages/routine/models/schedule_model.dart';
import 'package:skinsavvy/presentation/widgets/app_bar.dart';
import 'package:skinsavvy/presentation/widgets/button_option.dart';
import 'package:table_calendar/table_calendar.dart';

final filterCalendarProvider =
    StateNotifierProvider<FilterCalendarProvider, FilterCalendarState>((ref) {
  return FilterCalendarProvider();
});

class RoutinePage extends ConsumerStatefulWidget {
  const RoutinePage({super.key});

  @override
  ConsumerState<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends ConsumerState<RoutinePage> {
  DateTime todayDate = DateTime.now();

  ScheduleModel schedules = ScheduleModel.getSchedule();
  final List<String> filterCalendar = ['1 day', '3 days', '1 week', 'All'];

  @override
  Widget build(BuildContext context) {
    final filterState = ref.read(filterCalendarProvider.notifier);
    final filterStateValue = ref.watch(filterCalendarProvider);

    return Scaffold(
      appBar: appBar(context, 'Skincare Routine ✨', 16, false, true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _scheduleBannerSection(),
          const SizedBox(height: 32),
          _calendarSection(filterState, filterStateValue),
          const SizedBox(height: 32),
          Column(
            children: _scheduleItem(filterState, filterStateValue),
          )
        ],
      ),
    );
  }

  List<Column> _scheduleItem(
      FilterCalendarProvider state, FilterCalendarState stateValue) {
    // final int length = schedules.endDate.difference(schedules.startDate).inDays;

    final List<Column> listSchedule = [];
    DateTime currentDate = stateValue.startDate;
    int endDate = stateValue.endDate.difference(stateValue.startDate).inDays;

    for (var i = 0;
        i <= endDate &&
            currentDate
                .isBefore(schedules.endDate.add(const Duration(days: 1)));
        i++) {
      listSchedule.add(Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.blue[100],
              ),
              child: Text(
                '${(isSameDay(currentDate, DateTime.now()) ? 'Today,' : '')} ${currentDate.day} ${AppContent.months[currentDate.month - 1]} ${currentDate.year}',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              )),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const _CardSchedule(
                label: 'Morning Routine',
                imagePath: 'assets/images/routine/schedule_morning.png',
                products: [],
              ),
              const SizedBox(
                width: 8,
              ),
              _CardSchedule(
                label: 'Afternoon Routine',
                imagePath: 'assets/images/routine/schedule_afternoon.png',
                products: [],
                boxColor: AppTheme.secondaryColor.withOpacity(0.4),
              ),
              const SizedBox(
                width: 8,
              ),
              const _CardSchedule(
                label: 'Night Routine',
                imagePath: 'assets/images/routine/schedule_night.png',
                products: [],
                boxColor: AppTheme.dartTeal,
                textColor: Colors.white,
              )
            ],
          ),
          if (i < endDate)
            const SizedBox(
              height: 24,
            )
        ],
      ));
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return listSchedule;
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
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

  Container _calendarSection(
      FilterCalendarProvider state, FilterCalendarState stateValue) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: const [
              AppTheme.boxShadow,
            ]),
        child: Column(children: [
          TableCalendar(
            focusedDay: stateValue.startDate,
            rangeStartDay: stateValue.startDate,
            rangeEndDay: stateValue.endDate,
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
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                todayDate = selectedDay;
              });
              state.setFilter(filterCalendar[0]);
              state.setStartDate(selectedDay);
              state.setEndDate(selectedDay);
            },
            selectedDayPredicate: (day) {
              return isSameDay(stateValue.startDate, day);
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
              rangeEndDecoration: const BoxDecoration(
                color: AppTheme.secondaryColor,
                shape: BoxShape.circle,
              ),
              rangeEndTextStyle: const TextStyle(color: Colors.black),
              rangeHighlightColor: AppTheme.primary50,
              selectedTextStyle: const TextStyle(color: Colors.white),
              todayTextStyle: const TextStyle(color: Colors.white),
              weekendTextStyle: const TextStyle(color: Colors.black),
              outsideTextStyle: const TextStyle(color: Colors.black),
              outsideDaysVisible: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ButtonOption(
                      label: filterCalendar[1],
                      onPressed: () => {
                        setState(() {
                          todayDate = DateTime.now();
                        }),
                        state.setFilter(filterCalendar[1]),
                        state.setStartDate(DateTime.now()),
                        state.setEndDate(
                            DateTime.now().add(const Duration(days: 3))),
                      },
                      isSelected: stateValue.filter == filterCalendar[1],
                      fontSize: 12,
                      horizontalPadding: 4,
                      verticalPadding: 0,
                      borderColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ButtonOption(
                      label: filterCalendar[2],
                      onPressed: () => {
                        setState(() {
                          todayDate = DateTime.now();
                        }),
                        state.setFilter(filterCalendar[2]),
                        state.setStartDate(DateTime.now()),
                        state.setEndDate(
                            DateTime.now().add(const Duration(days: 7))),
                      },
                      isSelected: stateValue.filter == filterCalendar[2],
                      fontSize: 12,
                      horizontalPadding: 4,
                      verticalPadding: 0,
                      borderColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ButtonOption(
                      label: filterCalendar[3],
                      onPressed: () => {
                        setState(() {
                          todayDate = DateTime.now();
                        }),
                        state.setFilter(filterCalendar[3]),
                        state.setStartDate(schedules.startDate),
                        state.setEndDate(schedules.endDate),
                      },
                      isSelected: stateValue.filter == filterCalendar[3],
                      fontSize: 12,
                      horizontalPadding: 4,
                      verticalPadding: 0,
                      borderColor: Colors.grey,
                    ),
                  ),
                ]),
          )
        ]));
  }
}

class _CardSchedule extends StatelessWidget {
  final String label;
  final String imagePath;
  final List<ProductRoutine> products;
  final Color? boxColor;
  final Color? textColor;

  const _CardSchedule({
    this.boxColor,
    this.textColor,
    required this.label,
    required this.imagePath,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Pressed $label'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: boxColor ?? AppTheme.primaryColor.withOpacity(0.4),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  imagePath,
                  width: 60,
                  height: 60,
                ),
                Column(
                  children: [
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: textColor ?? Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      ),
                      child: Text(
                        '${products.length} Products',
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
