import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/cubit/onboarding/onboarding_cubit.dart';
import 'package:bank_sha/cubit/pin/pin_cubit.dart';
import 'package:bank_sha/cubit/set_ktp/set_ktp_cubit.dart';
import 'package:bank_sha/cubit/set_profile/set_profile_cubit.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/utils/theme.dart';
import 'package:bank_sha/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user/user_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthGetCurrentUserEvent()),
        ),
        BlocProvider(
          create: (context) => OnboardingCubit(),
        ),
        BlocProvider(
          create: (context) => SetProfileCubit(),
        ),
        BlocProvider(
          create: (context) => SetKtpCubit(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => PinCubit()..init(context),
        ),
      ],
      child: MaterialApp(
        theme: themeData(),
        debugShowCheckedModeBanner: false,
        title: 'Bank Sha',
        navigatorKey: Get.navigatorKey,
        home: const SplashView(),
        scrollBehavior: NoSplashColor(),
      ),
    );
  }
}

ThemeData themeData() {
  return ThemeData(
    scaffoldBackgroundColor: lightBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
      titleTextStyle: blackTextStyle.copyWith(
        fontSize: 20,
        fontWeight: semiBold,
      ),
    ),
  );
}

class NoSplashColor extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
