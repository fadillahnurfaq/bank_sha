import 'package:bank_sha/cubit/operator_card/selected_operator_cubit.dart';
import 'package:bank_sha/models/operator_card/operator_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/theme.dart';

class CardProvider extends StatelessWidget {
  final OperatorCardModel data;
  final bool isSelected;
  const CardProvider({super.key, required this.data, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Material(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20.0),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            context.read<SelectedOperatorCubit>().changeSelected(data);
          },
          child: Container(
            padding: const EdgeInsets.all(22.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border:
                  isSelected ? Border.all(color: blueColor, width: 2.0) : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  data.thumbnail!,
                  height: 30.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.name.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      data.status.toString(),
                      style: greyTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
