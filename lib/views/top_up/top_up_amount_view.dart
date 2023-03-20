import 'package:bank_sha/bloc/top_up/top_up_bloc.dart';
import 'package:bank_sha/models/top_up/top_up_form_model.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/buttons/q_text_button.dart';
import 'package:bank_sha/utils/dialog/loading.dart';
import 'package:bank_sha/utils/snackbar/show_custom_snackbar.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/utils/theme.dart';
import 'package:bank_sha/views/pin/pin_view.dart';
import 'package:bank_sha/views/top_up/top_up_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../utils/buttons/input_button.dart';

class TopUpAmountView extends StatefulWidget {
  final TopUpFormModel data;
  const TopUpAmountView({super.key, required this.data});

  @override
  State<TopUpAmountView> createState() => _TopUpAmountViewState();
}

class _TopUpAmountViewState extends State<TopUpAmountView> {
  final TextEditingController amountController = TextEditingController();

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
      create: (context) => TopUpBloc(),
      child: Scaffold(
        backgroundColor: darkBackgroundColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocConsumer<TopUpBloc, TopUpState>(
            listener: (context, state) async {
              if (state is TopUpFailedState) {
                Get.back();
                showCustomSnackbar(state.error);
              }
              if (state is TopupSuccessState) {
                await launchUrlString(state.redirectUrl);

                // ignore: use_build_context_synchronously
                context.read<AuthBloc>().add(
                      AuthUpdateBalanceEvent(
                        int.parse(
                          amountController.text.replaceAll(".", ""),
                        ),
                      ),
                    );

                Get.offAll(page: const TopUpSuccessView());
              }

              if (state is TopupLoadingState) {
                Loading.show();
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
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
                  SizedBox(
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
                  const SizedBox(
                    height: 30.0,
                  ),
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
                    title: "Checkout Now",
                    onPressed: () async {
                      if (amountController.text.isNotEmpty) {
                        if (await Get.to(page: const PinView()) == true) {
                          // ignore: use_build_context_synchronously
                          final authState = context.read<AuthBloc>().state;
                          // String pin = '';
                          if (authState is AuthSuccessState) {
                            // pin = ;
                            // ignore: use_build_context_synchronously
                            context
                                .read<TopUpBloc>()
                                .add(TopupPostEvent(widget.data.copyWith(
                                  pin: authState.user.pin!,
                                  amount:
                                      amountController.text.replaceAll(".", ""),
                                )));
                          }
                        }
                      } else {
                        showCustomSnackbar("Harus memasukkan nominal");
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
