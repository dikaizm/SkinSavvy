import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skinsavvy/core/themes/theme.dart';
import 'package:skinsavvy/presentation/notifiers/bottom_nav/bottom_nav_notifier.dart';
import 'package:skinsavvy/presentation/pages/home/home_page.dart';
import 'package:skinsavvy/presentation/pages/product_page.dart';
import 'package:skinsavvy/presentation/pages/profile_page.dart';
import 'package:skinsavvy/presentation/pages/routine_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bottomNavNotifier);

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: PageView(
        controller: state.controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          ProductPage(),
          RoutinePage(),
          ProfilePage(),
        ],
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            state.changeIndex(index);
          },
          currentIndex: state.index,
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/nav_home.svg',
                    width: 24, height: 24),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/nav_product.svg',
                    width: 24, height: 24),
                label: 'Products'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/nav_routine.svg',
                    width: 24, height: 24),
                label: 'Routine'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/nav_profile.svg',
                    width: 24, height: 24),
                label: 'Profile')
          ]),
    );
  }
}
