import 'package:bank_sha/views/home/widgets/service_card.dart';
import 'package:flutter/material.dart';

import '../../../models/home/home_service_model.dart';
import '../../../utils/state_util.dart';
import '../../../utils/theme.dart';

class CardMore extends StatelessWidget {
  final List<HomeServiceModel> moreServices;
  const CardMore({super.key, required this.moreServices});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          Container(
            height: 340.0,
            width: Get.width,
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: lightBackgroundColor,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Column(
              children: [
                Text(
                  'Do More With Us',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: moreServices.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: .9,
                  ),
                  itemBuilder: (context, index) {
                    HomeServiceModel data = moreServices[index];
                    return ServiceCard(data: data);
                  },
                ),
              ],
            ),
          ),
          Positioned(
              top: 10,
              right: 20,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close)))
        ],
      ),
    );
  }
}
