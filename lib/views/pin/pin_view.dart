import 'package:bank_sha/cubit/pin/pin_cubit.dart';
import 'package:bank_sha/cubit/pin/pin_error_cubit.dart';
import 'package:bank_sha/utils/theme.dart';
import 'package:bank_sha/views/pin/widgets/button_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinView extends StatelessWidget {
  const PinView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController pinController = TextEditingController(text: '');
    PinCubit pinCubit = context.read<PinCubit>();

    return BlocProvider(
      create: (context) => PinErrorCubit(),
      child: Scaffold(
        backgroundColor: darkBackgroundColor,
        body: Center(
          child: BlocSelector<PinCubit, String, String>(
            selector: (state) {
              return state;
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sha PIN',
                    style: whiteTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 72,
                  ),
                  BlocSelector<PinErrorCubit, bool, bool>(
                    selector: (state) {
                      return state;
                    },
                    builder: (context, isError) {
                      return SizedBox(
                        width: 200,
                        child: TextFormField(
                          enabled: false,
                          controller: pinController,
                          obscureText: true,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: greyColor,
                              ),
                            ),
                          ),
                          style: whiteTextStyle.copyWith(
                            fontSize: 36,
                            fontWeight: medium,
                            letterSpacing: 16,
                            color: isError ? redColor : whiteColor,
                            // color: redColor,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 66.0,
                  ),
                  Wrap(
                    spacing: 40.0,
                    runSpacing: 40.0,
                    alignment: WrapAlignment.center,
                    children: [
                      ButtonPin(
                        onTap: () {
                          pinCubit.addPin("1", context, pinController);
                        },
                        text: "1",
                      ),
                      ButtonPin(
                        onTap: () {
                          pinCubit.addPin("2", context, pinController);
                        },
                        text: "2",
                      ),
                      ButtonPin(
                        onTap: () {
                          pinCubit.addPin("3", context, pinController);
                        },
                        text: "3",
                      ),
                      ButtonPin(
                        onTap: () {
                          pinCubit.addPin("4", context, pinController);
                        },
                        text: "4",
                      ),
                      ButtonPin(
                        onTap: () {
                          pinCubit.addPin("5", context, pinController);
                        },
                        text: "5",
                      ),
                      ButtonPin(
                        onTap: () {
                          pinCubit.addPin("6", context, pinController);
                        },
                        text: "6",
                      ),
                      ButtonPin(
                        onTap: () {
                          pinCubit.addPin("7", context, pinController);
                        },
                        text: "7",
                      ),
                      ButtonPin(
                        onTap: () {
                          pinCubit.addPin("8", context, pinController);
                        },
                        text: "8",
                      ),
                      ButtonPin(
                        onTap: () {
                          pinCubit.addPin("9", context, pinController);
                        },
                        text: "9",
                      ),
                      ButtonPin(
                        onTap: () {
                          pinCubit.addPin("0", context, pinController);
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
                          pinCubit.deletePin(context, pinController);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                    ],
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
