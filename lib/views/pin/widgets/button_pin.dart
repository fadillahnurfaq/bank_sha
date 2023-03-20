import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class ButtonPin extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const ButtonPin({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(60.0, 60.0),
        backgroundColor: numberBackgroundColor,
        shape: const CircleBorder(),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: whiteTextStyle.copyWith(fontSize: 22.0, fontWeight: semiBold),
      ),
    );
  }
}
