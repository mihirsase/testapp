import 'package:flutter/material.dart';

class ButtonAtom extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Color color;
  final Color textColor;

  ButtonAtom({
    required this.title,
    required this.color,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: _button,
    );
  }

  Widget get _button {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: onPressed != null ? textColor : textColor.withOpacity(0.4),
          fontSize: 18,
        ),
      ),
    );
  }
}
