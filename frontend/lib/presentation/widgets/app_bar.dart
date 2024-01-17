import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skinsavvy/core/themes/theme.dart';

AppBar appBar(String title, double fontSize) {
  return AppBar(
    toolbarHeight: 56,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    ),
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: AppTheme.backgroundColor,
    scrolledUnderElevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 4),
        child: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/ui_bell.svg',
            width: 24,
            height: 24,
          ),
        ),
      )
    ],
  );
}
