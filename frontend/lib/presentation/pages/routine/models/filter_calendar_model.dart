import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterCalendarState extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  final String filter;

  const FilterCalendarState({
    required this.startDate,
    required this.endDate,
    required this.filter,
  });

  FilterCalendarState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    String? filter,
  }) {
    return FilterCalendarState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [startDate, endDate];
}

class FilterCalendarProvider extends StateNotifier<FilterCalendarState> {
  FilterCalendarProvider()
      : super(FilterCalendarState(
        startDate: DateTime.now(), 
        endDate: DateTime.now().add(const Duration(days: 7)),
        filter: '1 week'
      ));

  void setFilter(String filter) {
    state = state.copyWith(filter: filter);
  }

  void setStartDate(DateTime startDate) {
    state = state.copyWith(startDate: startDate);
  }

  void setEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
  }
}
