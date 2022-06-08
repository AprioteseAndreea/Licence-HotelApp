class FieldValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Enter email!';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) return 'Enter password';

    if (value.length < 7) {
      return 'Password must be more than 6 characters';
    }
    return null;
  }

  static String? Function(String? value)? validatePhoneNumber =
      (String? value) {
    if (value!.isEmpty) {
      return 'Please enter a phone number';
    } else if (value.substring(0, 1) != '0' || value.substring(1, 2) != '7') {
      return 'Phone number must begin with 07';
    } else if (value.length != 10) return 'Phone number must have 10 digits';
    return null;
  };
}
