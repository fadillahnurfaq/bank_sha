import 'package:bank_sha/models/home/home_service_model.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/views/data_provider/data_provider_view.dart';
import 'package:bank_sha/views/home/widgets/card_more.dart';
import 'package:bank_sha/views/home/widgets/do_something.dart';
import 'package:bank_sha/views/home/widgets/latest_transaction.dart';
import 'package:bank_sha/views/home/widgets/level_card.dart';
import 'package:bank_sha/views/home/widgets/send_again_card.dart';
import 'package:bank_sha/views/home/widgets/tips_card.dart';
import 'package:bank_sha/views/home/widgets/top_profile.dart';
import 'package:bank_sha/views/home/widgets/wallet_card.dart';
import 'package:bank_sha/views/top_up/top_up_view.dart';
import 'package:bank_sha/views/transfer/transfer_view.dart';
import 'package:flutter/material.dart';

import '../../utils/theme.dart';
import 'widgets/bottom_navbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<HomeServiceModel> moreServices = [
      HomeServiceModel(
        iconUrl: 'assets/ic_product_data.png',
        title: "Data",
        onTap: () {
          Get.to(page: const DataProviderView());
        },
      ),
      HomeServiceModel(
        iconUrl: 'assets/ic_product_water.png',
        title: "Water",
        onTap: () {},
      ),
      HomeServiceModel(
        iconUrl: 'assets/ic_product_stream.png',
        title: "Stream",
        onTap: () {},
      ),
      HomeServiceModel(
        iconUrl: 'assets/ic_product_movie.png',
        title: "Movie",
        onTap: () {},
      ),
      HomeServiceModel(
        iconUrl: 'assets/ic_product_food.png',
        title: "Food",
        onTap: () {},
      ),
      HomeServiceModel(
        iconUrl: 'assets/ic_product_travel.png',
        title: "Travel",
        onTap: () {},
      ),
    ];

    List<HomeServiceModel> homeServices = [
      HomeServiceModel(
        iconUrl: 'assets/ic_topup.png',
        title: "Top up",
        onTap: () {
          Get.to(page: const TopUpView());
        },
      ),
      HomeServiceModel(
        iconUrl: 'assets/ic_send.png',
        title: "Send",
        onTap: () {
          Get.to(page: const TransferView());
        },
      ),
      HomeServiceModel(
        iconUrl: 'assets/ic_withdraw.png',
        title: "Withdraw",
        onTap: () {},
      ),
      HomeServiceModel(
        iconUrl: 'assets/ic_more.png',
        title: "More",
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CardMore(moreServices: moreServices);
            },
          );
        },
      ),
    ];

    return Scaffold(
      bottomNavigationBar: const BottomNavbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: purpleColor,
        child: Image.asset("assets/ic_plus_circle.png"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopProfile(),
            const SizedBox(
              height: 30.0,
            ),
            const WalletCard(),
            const SizedBox(
              height: 20.0,
            ),
            const LevelCard(),
            const SizedBox(
              height: 30.0,
            ),
            DoSomething(homeServices: homeServices),
            const SizedBox(
              height: 30.0,
            ),
            const LatestTransaction(),
            const SizedBox(
              height: 30.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Send Again',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const SendAgainCard(),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Friendly Tips',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const TipsCard(),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
