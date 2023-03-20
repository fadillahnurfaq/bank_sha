import 'package:flutter/material.dart';

import '../../../models/home/home_service_model.dart';
import '../../../utils/theme.dart';
import 'service_card.dart';

class DoSomething extends StatelessWidget {
  final List<HomeServiceModel> homeServices;
  const DoSomething({super.key, required this.homeServices});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do Something',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: homeServices.length,
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            HomeServiceModel data = homeServices[index];
            return ServiceCard(data: data);
          },
        )
      ],
    );
  }
}
