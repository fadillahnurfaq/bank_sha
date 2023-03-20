import 'package:flutter/material.dart';

import '../theme.dart';

class QFilledButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback onPressed;
  const QFilledButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: purpleColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(56.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: 16.0,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }
}
