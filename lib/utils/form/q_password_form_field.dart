import 'package:bank_sha/cubit/password_form/pasword_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme.dart';

class QPasswordFormField extends StatelessWidget {
  final String? title;

  final TextEditingController controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int? maxLength;

  const QPasswordFormField({
    super.key,
    this.title,
    required this.controller,
    this.validator,
    this.maxLength,
    required this.isShowTitle,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordFormCubit(),
      child: BlocSelector<PasswordFormCubit, bool, bool>(
        selector: (state) {
          return state;
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isShowTitle)
                Text(
                  title!,
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              if (isShowTitle)
                const SizedBox(
                  height: 8.0,
                ),
              TextFormField(
                obscureText: state,
                controller: controller,
                keyboardType: keyboardType,
                validator: validator,
                maxLength: maxLength,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0)),
                  contentPadding: const EdgeInsets.all(12.0),
                  suffixIcon: IconButton(
                    onPressed: () {
                      // print("Pressed");
                      context.read<PasswordFormCubit>().changeVisible();
                    },
                    icon: state
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                onChanged: onChanged,
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          );
        },
      ),
    );
  }
}
