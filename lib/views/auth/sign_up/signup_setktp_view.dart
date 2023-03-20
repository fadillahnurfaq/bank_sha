import 'dart:convert';
import 'dart:io';

import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/models/auth/sign_up_form_model.dart';
import 'package:bank_sha/utils/snackbar/show_custom_snackbar.dart';
import 'package:bank_sha/views/auth/sign_up/sign_up_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cubit/set_ktp/set_ktp_cubit.dart';
import '../../../utils/buttons/q_filled_button.dart';
import '../../../utils/buttons/q_text_button.dart';
import '../../../utils/dialog/loading.dart';
import '../../../utils/state_util.dart';
import '../../../utils/theme.dart';

class SignUpSetKtpView extends StatelessWidget {
  final SignUpFormModel data;
  const SignUpSetKtpView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, auth) {
            if (auth is AuthFailedState) {
              Get.back();
              showCustomSnackbar(auth.error);
            }
            if (auth is AuthSuccessState) {
              Get.offAll(page: const SignUpSuccessView());
            }
            if (auth is AuthLoadingState) {
              Loading.show();
            }
          },
          builder: (context, auth) {
            return Column(
              children: [
                Container(
                  width: 155,
                  height: 50,
                  margin: const EdgeInsets.symmetric(
                    vertical: 50,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img_logo_light.png'),
                    ),
                  ),
                ),
                Text(
                  'Verify Your\nAccount',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: BlocBuilder<SetKtpCubit, XFile?>(
                    builder: (context, ktp) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            color: Colors.white,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                context.read<SetKtpCubit>().changeKtp();
                              },
                              child: Container(
                                height: 120.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: ktp == null
                                        ? null
                                        : DecorationImage(
                                            image: FileImage(
                                              File(ktp.path),
                                            ),
                                            fit: BoxFit.cover)),
                                child: ktp != null
                                    ? null
                                    : Center(
                                        child: Image.asset(
                                          "assets/ic_upload.png",
                                          // width: 32.0,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Passport/ID Card',
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: medium,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          QFilledButton(
                            title: "Continue",
                            onPressed: () {
                              if (ktp == null) {
                                showCustomSnackbar("Image cannot be empty");
                              } else {
                                context.read<AuthBloc>().add(
                                      AuthRegisterEvent(
                                        data.copyWith(
                                          ktp:
                                              "data:image/png;base64,${base64Encode(
                                            File(ktp.path).readAsBytesSync(),
                                          )}",
                                        ),
                                      ),
                                    );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          QTextButton(
                            title: "Skip for now",
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    AuthRegisterEvent(data),
                                  );
                            },
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
