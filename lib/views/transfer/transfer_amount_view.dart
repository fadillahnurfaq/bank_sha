import 'package:bank_sha/bloc/transfer/transfer_bloc.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/dialog/loading.dart';
import 'package:bank_sha/utils/snackbar/show_custom_snackbar.dart';
import 'package:bank_sha/utils/theme.dart';
import 'package:bank_sha/views/transfer/transfer_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../models/transfer/transfer_form_model.dart';
import '../../utils/buttons/input_button.dart';
import '../../utils/buttons/q_text_button.dart';
import '../../utils/state_util.dart';
import '../pin/pin_view.dart';

class TransferAmountView extends StatefulWidget {
  final TransferFormModel data;

  const TransferAmountView({super.key, required this.data});

  @override
  State<TransferAmountView> createState() => _TransferAmountViewState();
}

class _TransferAmountViewState extends State<TransferAmountView> {
  final TextEditingController amountController =
      TextEditingController(text: '');

  addAmount(String number) {
    amountController.text = amountController.text + number;
  }

  deleteAmount() {
    if (amountController.text.isNotEmpty) {
      amountController.text =
          amountController.text.substring(0, amountController.text.length - 1);
      if (amountController.text == '') {
        amountController.text = '0';
      }
    }
  }

  @override
  void initState() {
    amountController.addListener(() {
      final text = amountController.text;
      amountController.value = amountController.value.copyWith(
        text: NumberFormat.currency(
          locale: 'id',
          decimalDigits: 0,
          symbol: '',
        ).format(
          int.parse(
            text.replaceAll('.', ''),
          ),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferBloc(),
      child: Scaffold(
        backgroundColor: darkBackgroundColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: BlocConsumer<TransferBloc, TransferState>(
            listener: (context, state) {
              if (state is TransferFailedState) {
                Get.back();
                showCustomSnackbar(state.error);
              }

              if (state is TransferLoadingState) {
                Loading.show();
              }

              if (state is TransferSuccessState) {
                context.read<AuthBloc>().add(
                      AuthUpdateBalanceEvent(
                        int.parse(
                              amountController.text.replaceAll('.', ''),
                            ) *
                            -1,
                      ),
                    );

                Get.offAll(page: const TransferSuccessView());
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      'Total Amount',
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 67,
                  ),
                  Align(
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        enabled: false,
                        controller: amountController,
                        cursorColor: greyColor,
                        decoration: InputDecoration(
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: greyColor,
                            ),
                          ),
                          prefixIcon: Text(
                            "Rp ",
                            style: whiteTextStyle.copyWith(
                              fontSize: 36,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                        style: whiteTextStyle.copyWith(
                          fontSize: 36,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 66),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 40.0,
                    runSpacing: 40.0,
                    children: [
                      InputButton(
                        onTap: () {
                          addAmount("1");
                        },
                        text: "1",
                      ),
                      InputButton(
                        onTap: () {
                          addAmount("2");
                        },
                        text: "2",
                      ),
                      InputButton(
                        onTap: () {
                          addAmount("3");
                        },
                        text: "3",
                      ),
                      InputButton(
                        onTap: () {
                          addAmount("4");
                        },
                        text: "4",
                      ),
                      InputButton(
                        onTap: () {
                          addAmount("5");
                        },
                        text: "5",
                      ),
                      InputButton(
                        onTap: () {
                          addAmount("6");
                        },
                        text: "6",
                      ),
                      InputButton(
                        onTap: () {
                          addAmount("7");
                        },
                        text: "7",
                      ),
                      InputButton(
                        onTap: () {
                          addAmount("8");
                        },
                        text: "8",
                      ),
                      InputButton(
                        onTap: () {
                          addAmount("9");
                        },
                        text: "9",
                      ),
                      InputButton(
                        onTap: () {
                          addAmount("0");
                        },
                        text: "0",
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(60.0, 60.0),
                          backgroundColor: numberBackgroundColor,
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          deleteAmount();
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  QFilledButton(
                    title: "Continue",
                    onPressed: () async {
                      if (amountController.text.isNotEmpty) {
                        if (await Get.to(page: const PinView()) == true) {
                          // ignore: use_build_context_synchronously
                          final authState = context.read<AuthBloc>().state;

                          if (authState is AuthSuccessState) {
                            // ignore: use_build_context_synchronously
                            context.read<TransferBloc>().add(TransferPostEvent(
                                widget.data.copyWith(
                                    pin: authState.user.pin!,
                                    amount: amountController.text
                                        .replaceAll(".", ""))));
                          }
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  QTextButton(
                    title: "Terms & Conditions",
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
