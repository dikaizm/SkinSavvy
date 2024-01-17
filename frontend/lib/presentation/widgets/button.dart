import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skinsavvy/core/themes/theme.dart';

class Button extends StatefulWidget {
  final String label;
  final String iconPath;
  final String iconPosition;
  final double columnGap;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final double verticalPadding;
  final double horizontalPadding;
  final bool enabled;
  final bool elevated;
  final Function()? onPressed;

  const Button({
    super.key,
    required this.label,
    this.columnGap = 8.0,
    this.iconPath = '',
    this.iconPosition = 'left',
    this.backgroundColor = AppTheme.primaryColor,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 48,
    this.borderRadius = 12,
    this.fontSize = 16,
    this.verticalPadding = 16,
    this.horizontalPadding = 16,
    this.enabled = true,
    this.elevated = true,
    this.onPressed,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: GestureDetector(
        onTapDown: (_) => _handleTapDown(),
        onTapUp: (_) => _handleTapUp(),
        onTapCancel: _handleTapCancel,
        child: ElevatedButton(
            onPressed: widget.enabled ? widget.onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.backgroundColor,
              padding: EdgeInsets.symmetric(
                vertical: widget.verticalPadding,
                horizontal: widget.horizontalPadding,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              elevation: _isPressed ? 4 : 0,
              shadowColor: _isPressed ? Colors.grey : Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.iconPath.isNotEmpty && widget.iconPosition == 'left')
                  SvgPicture.asset(
                    widget.iconPath,
                    width: 24,
                    height: 24,
                  ),
                if (widget.iconPath.isNotEmpty && widget.iconPosition == 'left')
                  SizedBox(width: widget.columnGap),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.iconPath.isNotEmpty &&
                    widget.iconPosition == 'right')
                  SizedBox(width: widget.columnGap),
                if (widget.iconPath.isNotEmpty &&
                    widget.iconPosition == 'right')
                  SvgPicture.asset(
                    widget.iconPath,
                    width: 24,
                    height: 24,
                    color: widget.textColor,
                  ),
              ],
            )),
      ),
    );
  }

  void _handleTapDown() {
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp() {
    setState(() {
      _isPressed = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }
}
