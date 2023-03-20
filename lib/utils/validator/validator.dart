class Validator {
  static String? rule(
    String? value, {
    bool required = false,
  }) {
    if (required && value!.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  static String? required(
    dynamic value, {
    String? fieldName,
  }) {
    if (value is String || value == null) {
      if (value.toString() == "null") return "This field is required!";
      if (value.isEmpty) return "This field is required!";
    }
    return null;
  }

  static String? email(String? value) {
    if (value!.isEmpty) return "This field is required";

    final bool isValidEmail = RegExp(
            "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
        .hasMatch(value);

    if (!isValidEmail) {
      return "The email must be a valid email address.";
    }
    return null;
  }

  static String? phone(String? value) {
    if (value!.isEmpty) return "This field is required";

    final bool isValidPhone =
        RegExp("^(\\+62815|0815|62815|\\+0815|\\+62816|0816|62816|\\+0816|\\+62858|0858|62858|\\+0814|\\+62814|0814|62814|\\+0814)[0-9]{5,9}")
                .hasMatch(value) ||
            RegExp("^(\\+62|\\+0|0|62)8(1[123]|52|53|21|22|23)[0-9]{5,9}")
                .hasMatch(value);

    if (!isValidPhone) {
      return "The phone must be a valid phone number.";
    }
    return null;
  }

  static String? password(String? value) {
    if (value!.isEmpty) return "This field is required";

    if (value.length < 6) {
      return "The password must be at least 6 characters.";
    }

    return null;
  }

  static String? number(String? value) {
    if (value!.isEmpty) return "This field is required";

    final bool isNumber = RegExp(r"^[0-9]+$").hasMatch(value);
    if (!isNumber) {
      return "This field is not in a valid number format";
    }
    return null;
  }
}
