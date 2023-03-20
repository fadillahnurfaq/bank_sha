import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/views/home/home_view.dart';
import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class SignUpSuccessView extends StatelessWidget {
  const SignUpSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Akun Berhasil\nTerdaftar',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              'Grow your finance start\ntogether with us',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            QFilledButton(
              width: 190,
              title: "Get Started",
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
