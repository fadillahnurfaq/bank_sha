import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/models/user/user_model.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/form/q_form_field.dart';
import 'package:bank_sha/utils/form/q_password_form_field.dart';
import 'package:bank_sha/utils/snackbar/show_custom_snackbar.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/utils/theme.dart';
import 'package:bank_sha/utils/validator/validator.dart';
import 'package:bank_sha/views/profile/edit_profile_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/auth/edit_form_model.dart';
import '../../utils/dialog/loading.dart';

class EditProfileView extends StatelessWidget {
  final UserModel user;
  const EditProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController(text: user.username);
    final fullNameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final passwordController = TextEditingController(text: user.password);

    final GlobalKey<FormState> formState = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formState,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailedState) {
                Get.back();
                showCustomSnackbar(state.error);
              }

              if (state is AuthSuccessState) {
                Get.offAll(page: const EditProfileSuccessView());
              }
              if (state is AuthLoadingState) {
                Loading.show();
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(22.0),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    child: Column(
                      children: [
                        QFormField(
                          controller: usernameController,
                          isShowTitle: true,
                          title: "Username",
                          validator: Validator.required,
                        ),
                        QFormField(
                          controller: fullNameController,
                          isShowTitle: true,
                          title: "Full Name",
                          validator: Validator.required,
                        ),
                        QFormField(
                          controller: emailController,
                          isShowTitle: true,
                          title: "Email Address",
                          validator: Validator.email,
                        ),
                        QPasswordFormField(
                          controller: passwordController,
                          isShowTitle: true,
                          title: "Password",
                          validator: Validator.password,
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        QFilledButton(
                          title: "Update Now",
                          onPressed: () {
                            if (!formState.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              return;
                            } else {
                              FocusScope.of(context).unfocus();
                              // Get.to(page: const EditProfileSuccessView());
                              context.read<AuthBloc>().add(AuthUpdateUserEvent(
                                    EditFormModel(
                                        username: usernameController.text,
                                        name: fullNameController.text,
                                        email: emailController.text,
                                        password: passwordController.text),
                                  ));
                            }
                          },
                        )
                      ],
                    ),
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
