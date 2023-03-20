import 'package:bank_sha/cubit/operator_card/selected_package_cubit.dart';
import 'package:bank_sha/models/operator_card/operator_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/format_currency/format_currency.dart';
import '../../../utils/theme.dart';

class CardPackage extends StatelessWidget {
  final DataPlanModel dataPlan;
  final bool isSelected;
  const CardPackage(
      {super.key, required this.dataPlan, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: whiteColor,
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        onTap: () {
          context.read<SelectedPackageCubit>().changeSelected(dataPlan);
        },
        child: Container(
          height: 175.0,
          width: 155.0,
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border:
                isSelected ? Border.all(color: blueColor, width: 2.0) : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dataPlan.name!,
                style: blackTextStyle.copyWith(
                  fontSize: 32,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                formatCurrency(dataPlan.price!),
                style: greyTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
