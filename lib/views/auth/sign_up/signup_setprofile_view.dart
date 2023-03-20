import 'dart:convert';
import 'dart:io';

import 'package:bank_sha/models/auth/sign_up_form_model.dart';
import 'package:bank_sha/utils/buttons/q_filled_button.dart';
import 'package:bank_sha/utils/form/q_form_field.dart';
import 'package:bank_sha/utils/snackbar/show_custom_snackbar.dart';
import 'package:bank_sha/utils/state_util.dart';
import 'package:bank_sha/utils/validator/validator.dart';
import 'package:bank_sha/views/auth/sign_up/signup_setktp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../cubit/set_profile/set_profile_cubit.dart';
import '../../../utils/theme.dart';

class SignUpSetProfileView extends StatelessWidget {
  final SignUpFormModel data;
  const SignUpSetProfileView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formState = GlobalKey<FormState>();
    final pinController = TextEditingController(text: '');

    return Scaffold(
      body: SingleChildScrollView(
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
                child: BlocBuilder<SetProfileCubit, XFile?>(
                  builder: (context, profile) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.white,
                          shape: const CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              context.read<SetProfileCubit>().changePhoto();
                            },
                            child: Container(
                              height: 120.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: profile == null
                                    ? null
                                    : DecorationImage(
                                        image: FileImage(
                                          File(profile.path),
                                        ),
                                        fit: BoxFit.cover),
                              ),
                              child: profile != null
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
                          height: 16.0,
                        ),
                        Text(
                          data.name!,
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: medium,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        QFormField(
                          isShowTitle: true,
                          title: "Set Pin (6 digit number)",
                          controller: pinController,
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          validator: Validator.required,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        QFilledButton(
                          title: "Continue",
                          onPressed: () {
                            if (!formState.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              return;
                            } else if (pinController.text.length != 6) {
                              showCustomSnackbar("Pin harus 6 digit");
                            } else if (profile == null) {
                              showCustomSnackbar("Profile tidak boleh kosong");
                            } else {
                              Get.to(
                                page: SignUpSetKtpView(
                                  data: data.copyWith(
                                    profilePicture:
                                        "data:image/png;base64,${base64Encode(
                                      File(profile.path).readAsBytesSync(),
                                    )}",
                                    pin: pinController.text,
                                    ktp: "",
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
