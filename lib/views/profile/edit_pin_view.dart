import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/dialog/loading.dart';
import 'package:bank_sha/utils/form/q_form_field.dart';
import 'package:bank_sha/utils/snackbar/show_custom_snackbar.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/utils/theme.dart';
import 'package:bank_sha/utils/validator/validator.dart';
import 'package:bank_sha/views/profile/edit_profile_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPinView extends StatelessWidget {
  const EditPinView({super.key});

  @override
  Widget build(BuildContext context) {
    final oldPinController = TextEditingController(text: '');
    final newPinController = TextEditingController(text: '');
    final GlobalKey<FormState> formState = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Pin"),
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

              if (state is AuthLoadingState) {
                Loading.show();
              }

              if (state is AuthSuccessState) {
                Get.offAll(page: const EditProfileSuccessView());
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(22.0),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        QFormField(
                          controller: oldPinController,
                          isShowTitle: true,
                          title: "Old Pin",
                          isObsecure: true,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          validator: Validator.number,
                        ),
                        QFormField(
                          controller: newPinController,
                          isShowTitle: true,
                          title: "New Pin",
                          isObsecure: true,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          validator: Validator.number,
                        ),
                        QFilledButton(
                          title: "Update Now",
                          onPressed: () {
                            if (!formState.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              return;
                            } else {
                              FocusScope.of(context).unfocus();
                              context.read<AuthBloc>().add(AuthUpdatePinEvent(
                                  oldPinController.text,
                                  newPinController.text));
                            }
                          },
                        ),
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
