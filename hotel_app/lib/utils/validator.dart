class FieldValidator {
  static String? validateEmail(String? value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    if (value.isEmpty) {
      return 'Please enter the email!';
    }
    if (!emailValid) {
      return 'Please enter a valid email!';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) return 'Please enter password!';
    bool passwordValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(value);
    if (!passwordValid) {
      return 'Password must have minimum 6 chars, \nat least one uppercase letter, \none lowercase letter and one number!';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a phone number';
    } else if (value.substring(0, 1) != '0' || value.substring(1, 2) != '7') {
      return 'Phone number must begin with 07';
    } else if (value.length != 10) {
      return 'Phone number must have 10 digits';
    }
    return null;
  }
}
