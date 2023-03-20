import 'package:bank_sha/models/home/home_service_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class ServiceCard extends StatelessWidget {
  final HomeServiceModel data;
  const ServiceCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: whiteColor,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: InkWell(
            onTap: data.onTap,
            child: SizedBox(
              height: 70.0,
              width: 70.0,
              child: Center(
                child: Image.asset(
                  data.iconUrl!,
                  width: 26.0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          data.title!,
          style: blackTextStyle.copyWith(
            fontWeight: medium,
          ),
        )
      ],
    );
  }
}
