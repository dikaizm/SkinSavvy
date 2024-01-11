import 'package:flutter/material.dart';
import 'package:skinsavvy/core/themes/theme.dart';

class Button extends StatefulWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double fontSize;
  final double verticalPadding;
  final double horizontalPadding;
  final bool enabled;
  final bool elevated;
  final Function()? onPressed;

  const Button({
    Key? key,
    required this.label,
    this.backgroundColor = AppTheme.primaryColor,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.fontSize = 16,
    this.verticalPadding = 16,
    this.horizontalPadding = 16,
    this.enabled = true,
    this.elevated = true,
    this.onPressed,
  }) : super(key: key);

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
            foregroundColor: widget.textColor,
            padding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding,
              horizontal: widget.horizontalPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: _isPressed ? 4 : 0,
            shadowColor: _isPressed ? Colors.grey : Colors.transparent,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
