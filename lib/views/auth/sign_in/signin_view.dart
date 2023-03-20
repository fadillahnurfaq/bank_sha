import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/models/auth/sign_in_form_model.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/buttons/q_text_button.dart';
import 'package:bank_sha/utils/form/q_form_field.dart';
import 'package:bank_sha/utils/form/q_password_form_field.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/utils/validator/validator.dart';
import 'package:bank_sha/views/auth/sign_up/signup_view.dart';
import 'package:bank_sha/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/dialog/loading.dart';
import '../../../utils/snackbar/show_custom_snackbar.dart';
import '../../../utils/theme.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController(text: '');
    final passwordController = TextEditingController(text: '');
    final GlobalKey<FormState> formState = GlobalKey<FormState>();

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailedState) {
            Get.back();
            showCustomSnackbar(state.error);
          }
          if (state is AuthLoadingState) {
            Loading.show();
          }

          if (state is AuthSuccessState) {
            Get.offAll(page: const HomeView());
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Image.asset(
                    "assets/img_logo_light.png",
                    height: 50.0,
                    width: 150.0,
                  ),
                ),
                Text(
                  'Sign In &\nGrow Your Finance',
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
                  child: Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QFormField(
                            controller: emailController,
                            isShowTitle: true,
                            title: "Email Address",
                            validator: Validator.email),
                        const SizedBox(
                          height: 10.0,
                        ),
                        QPasswordFormField(
                          controller: passwordController,
                          isShowTitle: true,
                          validator: Validator.password,
                          title: "Password",
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password",
                              style: blueTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        QFilledButton(
                          title: "Sign In",
                          onPressed: () {
                            if (!formState.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              return;
                            } else {
                              // FocusScope.of(context).unfocus();

                              context
                                  .read<AuthBloc>()
                                  .add(AuthLoginEvent(SignInFormModel(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  )));
                              // return;
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                QTextButton(
                  title: "Sign Up",
                  onPressed: () {
                    Get.off(page: const SignUpView());
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
