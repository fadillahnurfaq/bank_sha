import 'package:flutter/material.dart';

import '../state_util.dart';

class Loading {
  static show() async {
    return await showDialog(
      barrierDismissible: false,
      context: Get.currentContext,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                width: 15,
              ),
              Text(
                "Mohon tunggu...",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              )
            ],
          ),
        );
      },
    );
  }
}
