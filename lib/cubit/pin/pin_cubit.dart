import 'package:bank_sha/cubit/pin/pin_error_cubit.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/views/auth/sign_in/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/snackbar/show_custom_snackbar.dart';
import '../../bloc/auth/auth_bloc.dart';

class PinCubit extends Cubit<String> {
  PinCubit() : super("");

  void init(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccessState) {
      emit(authState.user.pin!);
    }
  }

  void addPin(String number, BuildContext context,
      TextEditingController pinController) {
    if (pinController.text.length < 6) {
      pinController.text = pinController.text + number;
    }

    if (pinController.text.length == 6) {
      if (state.isEmpty) {
        Get.offAll(page: const SignInView());
        showCustomSnackbar(
          "Gagal Mendapatkan data pin",
        );
      } else {
        if (pinController.text == state) {
          Get.back(result: true);
        } else {
          context.read<PinErrorCubit>().changeError(true);
          showCustomSnackbar(
            "PIN yang anda masukkan salah. Silakan coba lagi.",
          );
        }
      }
    }
  }

  deletePin(BuildContext context, TextEditingController pinController) {
    if (pinController.text.isNotEmpty) {
      context.read<PinErrorCubit>().changeError(false);
      pinController.text =
          pinController.text.substring(0, pinController.text.length - 1);
    }
  }
}
