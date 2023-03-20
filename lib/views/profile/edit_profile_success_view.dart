import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/views/home/home_view.dart';
import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class EditProfileSuccessView extends StatelessWidget {
  const EditProfileSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nice Update!',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              'Your data is safe with\nour system',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            QFilledButton(
              width: 190.0,
              title: "Back to Home",
              onPressed: () {
                Get.offAll(page: const HomeView());
              },
            )
          ],
        ),
      ),
    );
  }
}
