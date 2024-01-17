import 'package:flutter/material.dart';

class ScheduleModel {
  final DateTime startDate;
  final DateTime endDate;
  final ScheduleDetail details;

  ScheduleModel({
    required this.startDate,
    required this.endDate,
    required this.details,
  });

  static ScheduleModel getSchedule() {
    return ScheduleModel(
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 14)),
      details: ScheduleDetail.getScheduleDetail(),
    );
  }
}

class ScheduleDetail {
  final List<Product> morning;
  final List<Product> afternoon;
  final List<Product> night;

  ScheduleDetail({
    required this.morning,
    required this.afternoon,
    required this.night,
  });

  static ScheduleDetail getScheduleDetail() {
    const String basePath = 'assets/images/routine';

    List<Product> morning = [];
    morning.add(Product(
      name: 'Cleanser',
      brand: 'Cetaphil',
      imagePath: '$basePath/product_example.jpg',
      schedule: Schedule(
        days: ['Mon', 'Wed', 'Fri'],
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 8, minute: 30),
      ),
    ));
    morning.add(Product(
      name: 'Cleanser',
      brand: 'Cetaphil',
      imagePath: '$basePath/product_example.jpg',
      schedule: Schedule(
        days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 8, minute: 30),
      ),
    ));

    List<Product> afternoon = [];
    afternoon.add(Product(
      name: 'Moisturizer',
      brand: 'Cetaphil',
      imagePath: '$basePath/product_example.jpg',
      schedule: Schedule(
        days: ['Mon', 'Wed', 'Fri'],
        startTime: const TimeOfDay(hour: 12, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 30),
      ),
    ));

    List<Product> night = [];
    night.add(Product(
      name: 'Moisturizer',
      brand: 'Cetaphil',
      imagePath: '$basePath/product_example.jpg',
      schedule: Schedule(
        days: ['Mon', 'Wed', 'Fri'],
        startTime: const TimeOfDay(hour: 20, minute: 0),
        endTime: const TimeOfDay(hour: 20, minute: 30),
      ),
    ));

    ScheduleDetail schedules = ScheduleDetail(
      morning: morning,
      afternoon: afternoon,
      night: night,
    );

    return schedules;
  }
}

class Product {
  final String name;
  final String brand;
  final String imagePath;
  final Schedule schedule;

  Product({
    required this.name,
    required this.brand,
    required this.imagePath,
    required this.schedule,
  });
}

class Schedule {
  final List<String> days;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  Schedule({
    required this.days,
    required this.startTime,
    required this.endTime,
  });
}
