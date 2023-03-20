import 'package:bank_sha/bloc/transaction/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/transaction/transaction_model.dart';
import '../../../utils/format_currency/format_currency.dart';
import '../../../utils/theme.dart';

getImageValue(TransactionModel transaction) {
  switch (transaction.transcationType!.code!) {
    case 'top_up':
      return 'assets/ic_transaction_topup.png';
    case 'internet':
      return 'assets/ic_transaction_electric.png';
    case 'transfer':
      return 'assets/ic_transaction_transfer.png';
    default:
      return 'assets/ic_transaction_withdraw.png';
  }
}

class LatestTransaction extends StatelessWidget {
  const LatestTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest Transactions',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(
          height: 14.0,
        ),
        BlocProvider(
          create: (context) => TransactionBloc()..add(GetTransactionEvent()),
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TransactionSuccessState) {
                ListView.builder(
                  itemCount: state.transactions.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    TransactionModel transaction = state.transactions[index];
                    return Container(
                      padding: const EdgeInsets.all(22.0),
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            getImageValue(transaction),
                            width: 48.0,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction.transcationType!.name.toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  DateFormat('MMM dd').format(
                                      transaction.createdAt ?? DateTime.now()),
                                  style: greyTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            formatCurrency(
                              transaction.amount ?? 0,
                              symbol:
                                  transaction.transcationType!.action! == 'cr'
                                      ? '+ '
                                      : '- ',
                            ),
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              if (state is TransactionFailedState) {
                return const SizedBox();
              }
              return const SizedBox();
            },
          ),
        )
      ],
    );
  }
}
