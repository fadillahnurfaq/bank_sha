import 'package:bank_sha/bloc/payment_method/payment_method_bloc.dart';
import 'package:bank_sha/models/top_up/top_up_form_model.dart';
import 'package:bank_sha/models/transaction/transaction_model.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/views/top_up/top_up_amount_view.dart';
import 'package:bank_sha/views/top_up/widgets/bank_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../cubit/payment_method/selected_payment_method_cubit.dart';
import '../../utils/state_util.dart';
import '../../utils/theme.dart';

class TopUpView extends StatelessWidget {
  const TopUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectedPaymentMethodCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Top Up"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'Wallet',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthSuccessState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.cardNumber!.replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          state.user.name.toString(),
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                'Select Bank',
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
                    PaymentMethodBloc()..add(PaymentMethodGetEvent()),
                child: BlocSelector<SelectedPaymentMethodCubit,
                    PaymentMethodModel?, PaymentMethodModel?>(
                  selector: (selectedPayment) {
                    return selectedPayment;
                  },
                  builder: (context, selectedPayment) {
                    return BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
                      builder: (context, state) {
                        if (state is PaymentMethodLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is PaymentMethodSuccess) {
                          return Column(
                            children: state.paymentMethods
                                .map((paymentMethod) => BankCard(
                                      paymentMethod: paymentMethod,
                                      isSelected: selectedPayment == null
                                          ? false
                                          : paymentMethod.id ==
                                              selectedPayment.id,
                                      onTap: () {
                                        context
                                            .read<SelectedPaymentMethodCubit>()
                                            .changeSelectedPayment(
                                                paymentMethod);
                                      },
                                    ))
                                .toList(),
                          );
                        }
                        return const SizedBox();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 70.0,
              ),
            ],
          ),
        ),
        floatingActionButton: BlocSelector<SelectedPaymentMethodCubit,
            PaymentMethodModel?, PaymentMethodModel?>(
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
                          page: TopUpAmountView(
                            data: TopUpFormModel(paymentMethodCode: state.code),
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
