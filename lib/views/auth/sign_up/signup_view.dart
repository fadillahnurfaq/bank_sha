import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/models/auth/sign_up_form_model.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/buttons/q_text_button.dart';
import 'package:bank_sha/utils/dialog/loading.dart';
import 'package:bank_sha/utils/form/q_form_field.dart';
import 'package:bank_sha/utils/form/q_password_form_field.dart';
import 'package:bank_sha/utils/snackbar/show_custom_snackbar.dart';
import 'package:bank_sha/views/auth/sign_in/signin_view.dart';
import 'package:bank_sha/views/auth/sign_up/signup_setprofile_view.dart';
import 'package:flutter/material.dart';
import 'package:bank_sha/utils/validator/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/state_util.dart';
import '../../../utils/theme.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: '');
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
          if (state is AuthCheckEmailSuccessState) {
            Get.back();
            Get.to(
                page: SignUpSetProfileView(
                    data: SignUpFormModel(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text,
            )));
          }
          if (state is AuthLoadingState) {
            Loading.show();
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
                    'assets/img_logo_light.png',
                    height: 50.0,
                    width: 150.0,
                  ),
                ),
                Text(
                  'Join Us to Unlock\nYour Growth',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QFormField(
                          title: "Full Name",
                          controller: nameController,
                          validator: Validator.required,
                          isShowTitle: true,
                        ),
                        QFormField(
                          isShowTitle: true,
                          title: "Email Address",
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validator.required,
                        ),
                        QPasswordFormField(
                          isShowTitle: true,
                          title: "Password",
                          controller: passwordController,
                          validator: Validator.required,
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        QFilledButton(
                          title: "Continue",
                          onPressed: () {
                            if (!formState.currentState!.validate()) {
                              // FocusScope.of(context).unfocus();
                              return;
                            } else {
                              // FocusScope.of(context).unfocus();
                              context.read<AuthBloc>().add(
                                  AuthCheckEmailEvent(emailController.text));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                QTextButton(
                  title: "Sign In",
                  onPressed: () {
                    Get.off(page: const SignInView());
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
