// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignInFormModel {
  final String? email;
  final String? password;

  SignInFormModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() => 'SignInFormModel(email: $email, password: $password)';
}
