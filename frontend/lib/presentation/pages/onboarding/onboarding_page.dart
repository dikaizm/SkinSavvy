import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skinsavvy/core/themes/theme.dart';

import '../../../core/routes.dart';
import '../../widgets/button_gradient.dart';
import '../../widgets/button_option.dart';
import 'models/onboarding_model.dart';

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
  final _nameController = TextEditingController();

  final List<String> genderOptions = ['Male', 'Female'];
  final List<String> ageOptions = ['12 - 29', '30 - 39', '40 - 49', '50+'];
  final List<String> activityTypeOptions = ['Outdoor', 'Indoor'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.read(onboardingProvider.notifier);
    final stateValue = ref.watch(onboardingProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        title: Image.asset(
          'assets/images/logo_skinsavvy.png',
          height: 40,
        ),
      ),
      backgroundColor: AppTheme.primary50,
      body: Container(
        color: AppTheme.backgroundColor,
        child: Material(
          color: AppTheme.linen,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                _nameForm(state, stateValue),
                const SizedBox(height: 32),
                _genderOptions(state, stateValue),
                if (stateValue.gender.isNotEmpty)
                  const SizedBox(
                    height: 32,
                  ),
                if (stateValue.gender.isNotEmpty)
                  _ageOptions(state, stateValue),
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
                    onPressed: () {
                      // Validate name
                      if (state.getName().trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Name cannot be empty'),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }

                      // Call API to save user data
                      // if success, navigate to analyze skin page, else show error
                      Navigator.pushNamed(context, AppRoutes.analyzeSkin);
                    },
                  ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _nameForm(OnboardingProvider state, OnboardingState stateValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What\'s your name?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _nameController,
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onSubmitted: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onEditingComplete: () {
              state.setName(_nameController.text);
            },
            decoration: const InputDecoration(
              hintText: 'Enter your name',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.label_outline_rounded),
              prefixIconColor: Colors.black45,
            ),
          ),
        ),
      ],
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
                image: Image.asset('assets/images/form_male.png', height: 67),
                label: 'I\'m Male',
                onPressed: () => state.setGender(genderOptions[0]),
                isSelected: stateValue.gender == genderOptions[0],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: ButtonOption(
                image: Image.asset('assets/images/form_female.png', height: 67),
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
    OnboardingProvider state,
    OnboardingState stateValue,
  ) {
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
                image: Image.asset(
                  'assets/images/form_outdoor.png',
                  height: 67,
                ),
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
                image: Image.asset(
                  'assets/images/form_indoor.png',
                  height: 67,
                ),
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
