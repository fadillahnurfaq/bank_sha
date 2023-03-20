import 'package:another_flushbar/flushbar.dart';
import 'package:bank_sha/utils/state_util.dart';

import '../theme.dart';

void showCustomSnackbar(String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    duration: const Duration(seconds: 3),
  ).show(Get.currentContext);
}
