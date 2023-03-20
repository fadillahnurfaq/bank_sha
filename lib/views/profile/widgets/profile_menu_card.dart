import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class ProfileMenuCard extends StatelessWidget {
  final String title, imageUrl;
  final VoidCallback onTap;
  const ProfileMenuCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: whiteColor,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 50.0,
          child: Row(
            children: [
              Image.asset(
                imageUrl,
                width: 24.0,
              ),
              const SizedBox(
                width: 18,
              ),
              Text(
                title,
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
