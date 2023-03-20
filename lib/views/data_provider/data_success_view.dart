import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/views/home/home_view.dart';
import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class DataSuccessView extends StatelessWidget {
  const DataSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Paket Data\nBerhasil Terbeli',
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
              'Use the money wisely and\ngrow your finance',
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
              title: "Back To Home",
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
