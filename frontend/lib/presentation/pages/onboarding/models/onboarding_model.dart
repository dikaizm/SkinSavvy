import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final String gender;
  final String age;
  final String activityType;

  const OnboardingState({
    required this.gender,
    required this.age,
    required this.activityType,
  });

  OnboardingState copyWith({
    String? gender,
    String? age,
    String? activityType,
  }) {
    return OnboardingState(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      activityType: activityType ?? this.activityType,
    );
  }
}

class OnboardingProvider extends StateNotifier<OnboardingState> {
  OnboardingProvider() : super(const OnboardingState(gender: '', age: '', activityType: ''));

  void setGender(String selectedGender) {
    state = state.copyWith(gender: selectedGender);
  }

  void setAge(String selectedAge) {
    state = state.copyWith(age: selectedAge);
  }

  void setActivityType(String selectedActivityType) {
    state = state.copyWith(activityType: selectedActivityType);
  }
}