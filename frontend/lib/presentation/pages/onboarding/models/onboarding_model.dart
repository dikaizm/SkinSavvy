import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skinsavvy/services/shared_service.dart';

class OnboardingState extends Equatable {
  final String name;
  final String gender;
  final String age;
  final String activityType;

  const OnboardingState({
    required this.name,
    required this.gender,
    required this.age,
    required this.activityType,
  });

  OnboardingState copyWith({
    String? name,
    String? gender,
    String? age,
    String? activityType,
  }) {
    return OnboardingState(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      activityType: activityType ?? this.activityType,
    );
  }

  @override
  List<Object?> get props => [name, gender, age, activityType];
}

class OnboardingProvider extends StateNotifier<OnboardingState> {
  OnboardingProvider()
      : super(const OnboardingState(
            name: '', gender: '', age: '', activityType: ''));

  String getName() {
    return state.name;
  }

  void setName(String name) {
    state = state.copyWith(name: name);
    SharedService.saveData('name', name);
  }

  void setGender(String selectedGender) {
    state = state.copyWith(gender: selectedGender);
    SharedService.saveData('gender', selectedGender);
  }

  void setAge(String selectedAge) {
    state = state.copyWith(age: selectedAge);
    SharedService.saveData('age', selectedAge);
  }

  void setActivityType(String selectedActivityType) {
    state = state.copyWith(activityType: selectedActivityType);
    SharedService.saveData('activityType', selectedActivityType);
  }
}
