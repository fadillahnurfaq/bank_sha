import 'package:flutter/material.dart';

import '../theme.dart';

class QFormField extends StatelessWidget {
  final String? title;
  final bool isObsecure;
  final TextEditingController controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int? maxLength;

  const QFormField({
    super.key,
    this.title,
    required this.controller,
    this.validator,
    this.maxLength,
    this.isObsecure = false,
    required this.isShowTitle,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
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
          obscureText: isObsecure,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: isShowTitle ? null : title,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(14.0)),
            contentPadding: const EdgeInsets.all(12.0),
          ),
          onChanged: onChanged,
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
