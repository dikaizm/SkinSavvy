import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skinsavvy/core/themes/theme.dart';
import 'package:skinsavvy/presentation/widgets/button.dart';

class ButtonGradient extends Button {
  const ButtonGradient(
      {required super.label,
      super.key,
      super.onPressed,
      super.horizontalPadding = 16,
      super.verticalPadding = 16});

  @override
  State<ButtonGradient> createState() => _ButtonGradientState();
}

class _ButtonGradientState extends State<ButtonGradient> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            shape: BoxShape.rectangle,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryColor,
                AppTheme.orangeColor,
              ],
            ),
          ),
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.symmetric(
                vertical: widget.verticalPadding,
                horizontal: widget.horizontalPadding,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                SvgPicture.asset(
                  'assets/icons/arrow_right.svg',
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          ),
        ));
  }
}
