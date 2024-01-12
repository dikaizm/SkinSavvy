import 'package:flutter/material.dart';
import 'package:skinsavvy/core/themes/theme.dart';
import 'package:skinsavvy/presentation/widgets/button.dart';

class ButtonOption extends Button {
  final bool isSelected;

  const ButtonOption({
    required this.isSelected,
    required super.label,
    super.key,
    super.height = 42,
    super.backgroundColor = AppTheme.neutralColor100,
    super.textColor = Colors.black,
    super.onPressed,
    super.horizontalPadding = 8,
    super.verticalPadding = 8,
  });

  @override
  State<ButtonOption> createState() => _ButtonOptionState();
}

class _ButtonOptionState extends State<ButtonOption> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.isSelected
                ? AppTheme.primaryColor.withOpacity(0.2)
                : AppTheme.neutralColor100,
            padding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding,
              horizontal: widget.horizontalPadding,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: widget.isSelected
                      ? AppTheme.primaryColor
                      : AppTheme.neutralColor300,
                  width: 1.0,
                )),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )),
    );
  }
}
