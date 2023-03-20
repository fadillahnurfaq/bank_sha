import 'package:flutter/material.dart';

import '../../../models/transaction/transaction_model.dart';
import '../../../utils/theme.dart';

class BankCard extends StatelessWidget {
  final PaymentMethodModel paymentMethod;
  final bool isSelected;
  final VoidCallback onTap;
  const BankCard({
    super.key,
    required this.paymentMethod,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Material(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20.0),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(22.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border:
                  isSelected ? Border.all(width: 2, color: blueColor) : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                paymentMethod.thumbnail == ''
                    ? Image.asset(
                        'assets/img_bank_bca.png',
                        height: 30,
                      )
                    : Image.network(paymentMethod.thumbnail.toString(),
                        height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      paymentMethod.name.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '50 mins',
                      style: greyTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    )
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
