class Validation {
  static bool emailValidator(String email) {
    final emailValid = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
    return emailValid;
  }
}
