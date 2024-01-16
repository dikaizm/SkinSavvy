import 'package:flutter/material.dart';

import '../../core/themes/theme.dart';
import 'button.dart';

class ButtonOption extends Button {
  final bool isSelected;
  final Image? image;

  const ButtonOption({
    required this.isSelected,
    required super.label,
    this.image,
    super.key,
    super.height = 42,
    super.backgroundColor = Colors.white,
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
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isSelected
            ? AppTheme.primaryColor.withOpacity(0.3)
            : widget.backgroundColor,
        padding: EdgeInsets.symmetric(
          vertical: widget.verticalPadding,
          horizontal: widget.horizontalPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: widget.isSelected
                ? AppTheme.primaryColor
                : widget.backgroundColor,
            width: 1.0,
          ),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.image ?? Container(),
            if (widget.image != null) const SizedBox(height: 12),
            Text(
              widget.label,
              style: TextStyle(
                color: widget.textColor,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
