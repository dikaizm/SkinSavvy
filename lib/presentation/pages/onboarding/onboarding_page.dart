import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skinsavvy/main.dart';
import 'package:skinsavvy/presentation/pages/onboarding/models/onboarding_model.dart';
import 'package:skinsavvy/presentation/widgets/button_gradient.dart';
import 'package:skinsavvy/presentation/widgets/button_option.dart';

final onboardingProvider =
    StateNotifierProvider<OnboardingProvider, OnboardingState>((ref) {
  return OnboardingProvider();
});

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  List<String> genderOptions = ['Male', 'Female'];
  List<String> ageOptions = ['12 - 29', '30 - 39', '40 - 49', '50+'];
  List<String> activityTypeOptions = ['Outdoor', 'Indoor'];

  @override
  Widget build(BuildContext context) {
    final state = ref.read(onboardingProvider.notifier);
    final stateValue = ref.watch(onboardingProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: ListView(
          children: [
            Image.asset(
              'assets/images/logo_skinsavvy.png',
              height: 40,
            ),
            const SizedBox(height: 32),
            _genderOptions(state, stateValue),
            if (stateValue.gender.isNotEmpty)
              const SizedBox(
                height: 32,
              ),
            if (stateValue.gender.isNotEmpty) _ageOptions(state, stateValue),
            if (stateValue.age.isNotEmpty)
              const SizedBox(
                height: 32,
              ),
            if (stateValue.age.isNotEmpty)
              _activityTypeOptions(state, stateValue),
            if (stateValue.activityType.isNotEmpty)
              const SizedBox(
                height: 48,
              ),
            if (stateValue.activityType.isNotEmpty)
              ButtonGradient(
                label: 'Analyze my skin',
                onPressed: () => {
                  // Call API to save user data
                  // if success, navigate to analyze skin page, else show error
                  Navigator.pushNamed(context, AppRoutes.analyzeSkin)
                },
              ),
          ],
        ),
      ),
    );
  }

  Column _genderOptions(OnboardingProvider state, OnboardingState stateValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What\'s your gender?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ButtonOption(
                label: 'I\'m Male',
                onPressed: () => state.setGender(genderOptions[0]),
                isSelected: stateValue.gender == genderOptions[0],
                height: 120,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: ButtonOption(
                label: 'I\'m Female',
                onPressed: () => state.setGender(genderOptions[1]),
                isSelected: stateValue.gender == genderOptions[1],
                height: 120,
              ),
            ),
          ],
        )
      ],
    );
  }

  Column _ageOptions(OnboardingProvider state, OnboardingState stateValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How old are you?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ButtonOption(
                label: ageOptions[0],
                onPressed: () => state.setAge(ageOptions[0]),
                isSelected: stateValue.age == ageOptions[0],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: ButtonOption(
                label: ageOptions[1],
                onPressed: () => state.setAge(ageOptions[1]),
                isSelected: stateValue.age == ageOptions[1],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ButtonOption(
                label: ageOptions[2],
                onPressed: () => state.setAge(ageOptions[2]),
                isSelected: stateValue.age == ageOptions[2],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: ButtonOption(
                label: ageOptions[3],
                onPressed: () => state.setAge(ageOptions[3]),
                isSelected: stateValue.age == ageOptions[3],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _activityTypeOptions(
      OnboardingProvider state, OnboardingState stateValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Do you regularly engage in outdoor activities?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ButtonOption(
                label: 'Yes',
                onPressed: () => state.setActivityType(activityTypeOptions[0]),
                isSelected: stateValue.activityType == activityTypeOptions[0],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: ButtonOption(
                label: 'No',
                onPressed: () => state.setActivityType(activityTypeOptions[1]),
                isSelected: stateValue.activityType == activityTypeOptions[1],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
