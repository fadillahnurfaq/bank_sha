import 'package:flutter/material.dart';

import '../theme.dart';

class QTextButton extends StatelessWidget {
  final String title;

  final VoidCallback onPressed;

  const QTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: onPressed,
      child: Text(
        title,
        style: greyTextStyle.copyWith(
          fontWeight: semiBold,
        ),
      ),
    );
  }
}
