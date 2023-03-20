import 'dart:async';

import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/utils/theme.dart';
import 'package:bank_sha/views/home/home_view.dart';
import 'package:bank_sha/views/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          Timer(
            const Duration(seconds: 2),
            () {
              if (state is AuthSuccessState) {
                Get.offAll(page: const HomeView());
              }

              if (state is AuthFailedState) {
                Get.offAll(page: const OnboardingView());
              }
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Image.asset(
                "assets/img_logo_dark.png",
                height: 50.0,
                width: 155.0,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
