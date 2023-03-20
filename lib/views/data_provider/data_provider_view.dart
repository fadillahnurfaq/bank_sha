import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/bloc/operator_card/operator_card_bloc.dart';
import 'package:bank_sha/cubit/operator_card/selected_operator_cubit.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/views/data_provider/data_package_view.dart';
import 'package:bank_sha/views/data_provider/widgets/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/operator_card/operator_card_model.dart';
import '../../utils/format_currency/format_currency.dart';
import '../../utils/theme.dart';

class DataProviderView extends StatelessWidget {
  const DataProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectedOperatorCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Beli Data"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'From Wallet',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/img_wallet.png",
                    width: 80.0,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthSuccessState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user.cardNumber!.replaceAllMapped(
                                  RegExp(r".{4}"),
                                  (match) => "${match.group(0)} "),
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Balance: ${formatCurrency(state.user.balance ?? 0)}',
                              style: greyTextStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'Select Provider',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              BlocProvider(
                create: (context) =>
                    OperatorCardBloc()..add(OperatorCardGetEvent()),
                child: BlocBuilder<OperatorCardBloc, OperatorCardState>(
                  builder: (context, state) {
                    if (state is OperatorCardLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is OperatorCardSucessState) {
                      return ListView.builder(
                        itemCount: state.operatorCards.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          OperatorCardModel data = state.operatorCards[index];
                          return BlocSelector<SelectedOperatorCubit,
                              OperatorCardModel?, OperatorCardModel?>(
                            selector: (state) {
                              return state;
                            },
                            builder: (context, state) {
                              return CardProvider(
                                data: data,
                                isSelected:
                                    state == null ? false : data == state,
                              );
                            },
                          );
                        },
                      );
                    }
                    if (state is OperatorCardFailedState) {
                      return Text(state.error);
                    }
                    return const SizedBox();
                  },
                ),
              ),
              const SizedBox(
                height: 70.0,
              )
            ],
          ),
        ),
        floatingActionButton: BlocSelector<SelectedOperatorCubit,
            OperatorCardModel?, OperatorCardModel?>(
          selector: (state) {
            return state;
          },
          builder: (context, state) {
            return state != null
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: QFilledButton(
                      title: "Continue",
                      onPressed: () {
                        Get.to(
                          page: DataPackageView(
                            operatorCard: state,
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
