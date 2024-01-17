import 'package:flutter/material.dart';
import 'package:skinsavvy/core/themes/theme.dart';

class ExploreModel {
  final User user;
  final String review;
  final String imagePath;
  final Color boxColor;

  ExploreModel({
    required this.user,
    required this.review,
    required this.imagePath,
    required this.boxColor,
  });

  static List<ExploreModel> getExplore() {
    const String basePath = 'assets/images/home';

    List<ExploreModel> explore = [];

    explore.add(ExploreModel(
      user: User(
        name: 'Amanda',
        age: 20,
        skinConcerns: ['Acne', 'Dry Skin'],
      ),
      review:
          'I have been using this product for 2 months and I can see the difference. My skin is more moisturized and the acne scars are fading away.',
      imagePath: '$basePath/explore_example.png',
      boxColor: AppTheme.linen
    ));

    explore.add(ExploreModel(
      user: User(
        name: 'Nadya',
        age: 20,
        skinConcerns: ['Acne', 'Dry Skin'],
      ),
      review:
          'I have been using this product for 2 months and I can see the difference. My skin is more moisturized and the acne scars are fading away.',
      imagePath: '$basePath/explore_example.png',
      boxColor: AppTheme.primary50
    ));

    explore.add(ExploreModel(
      user: User(
        name: 'Sarah',
        age: 20,
        skinConcerns: ['Acne', 'Dry Skin'],
      ),
      review:
          'I have been using this product for 2 months and I can see the difference. My skin is more moisturized and the acne scars are fading away.',
      imagePath: '$basePath/explore_example.png',
      boxColor: AppTheme.linen
    ));

    return explore;
  }
}

class User {
  final String name;
  final int age;
  final List<String> skinConcerns;

  User({
    required this.name,
    required this.age,
    required this.skinConcerns,
  });
}
