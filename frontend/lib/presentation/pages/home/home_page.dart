import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skinsavvy/core/routes.dart';
import 'package:skinsavvy/core/themes/theme.dart';
import 'package:skinsavvy/presentation/pages/home/models/category_model.dart';
import 'package:skinsavvy/presentation/pages/home/models/explore_model.dart';
import 'package:skinsavvy/presentation/widgets/app_bar.dart';
import 'package:skinsavvy/presentation/widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<ExploreModel> explore = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    explore = ExploreModel.getExplore();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();

    String getGreeting() {
      var hour = DateTime.now().hour;

      if (hour < 12) {
        return 'Morning';
      } else if (hour < 18) {
        return 'Afternoon';
      } else {
        return 'Evening';
      }
    }

    return Scaffold(
        appBar: appBar(context, '${getGreeting()}, Nadya!', 20, false, true),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _bannerSection(),
            const SizedBox(height: 32),
            _searchField(),
            const SizedBox(height: 32),
            _categoriesSection(),
            const SizedBox(height: 32),
            _exploreSection(),
          ],
        ));
  }

  Container _bannerSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home/banner_bg.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // color: Colors.transparent
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Skin\'s Progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Button(
                  label: 'Check out',
                  borderRadius: 40,
                  width: 140,
                  verticalPadding: 4,
                  horizontalPadding: 4,
                  backgroundColor: Colors.white,
                  fontSize: 12,
                  textColor: Colors.black,
                  iconPath: 'assets/icons/arrow_right.svg',
                  iconPosition: 'right',
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.skinProgress);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/images/home/banner_progress.png',
              height: 120,
            ),
          )
        ],
      ),
    );
  }

  Container _searchField() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xff1D1617).withOpacity(0.1),
          spreadRadius: 0.0,
          blurRadius: 40,
        )
      ]),
      child: TextField(
          decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(15),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/icons/search.svg'),
        ),
      )),
    );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Activity by Category',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var item in categories) ...{
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, item.route);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.linen,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff1D1617).withOpacity(0.1),
                          spreadRadius: 0.0,
                          offset: const Offset(0, 4),
                          blurRadius: 16,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 54,
                          width: 54,
                          decoration:
                              const BoxDecoration(shape: BoxShape.rectangle),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Image.asset(
                              item.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (item != categories.last) const SizedBox(width: 12),
            }
          ],
        )
      ],
    );
  }

  Column _exploreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Explore',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 16),
        Column(
          children: [
            for (var item in explore) ...{
              Container(
                decoration: BoxDecoration(
                  color: item.boxColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff1D1617).withOpacity(0.1),
                      spreadRadius: 0.0,
                      offset: const Offset(0, 4),
                      blurRadius: 16,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 16, left: 16, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item.imagePath,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            ListTile(
                              horizontalTitleGap: 12,
                              contentPadding: const EdgeInsets.all(0),
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    item.user.name.substring(0, 1),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                item.user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                '${item.user.age} yo | ${item.user.skinConcerns.join(', ')}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              item.review,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            },
          ],
        )
      ],
    );
  }
}
