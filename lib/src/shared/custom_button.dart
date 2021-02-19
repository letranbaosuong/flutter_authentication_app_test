import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color color;
  final Color textColor;
  final Color borderColor;

  const CustomButton({
    Key key,
    @required this.onPressed,
    @required this.buttonText,
    this.color,
    this.textColor,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      color: color,
      textColor: textColor,
      child: Text(buttonText),
      padding: const EdgeInsets.all(14),
    );
  }
}