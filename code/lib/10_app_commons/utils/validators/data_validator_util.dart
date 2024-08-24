class DataValidatorUtil {
  // static bool isValidEmail(String email) {
  //   return EmailValidator.validate(email);
  // }

  static String formatPhoneNumber(String phoneNumber) {
    phoneNumber = phoneNumber.replaceAll(" ", "");
    phoneNumber = phoneNumber.replaceAll(".", "");
    return phoneNumber;
  }

  static bool isValidPhoneNumber(String phone) {
    if (phone.length != 10) return false;
    var regex = RegExp("[0][0-9]{9}");
    return regex.hasMatch(phone);
  }

  // static bool isValidUserCode(String userCode) {
  //   if (!isValidEmail(userCode)) {
  //     String phoneNumber = formatPhoneNumber(userCode);
  //     if (!isValidPhoneNumber(phoneNumber)) {
  //       return false;
  //     }
  //   }
  //   return true;
  // }

  static bool isValidPassword(String password) {
    if (password.length < 6) return false;
    return true;
  }

  static bool isLetterAndNumbers(String input) {
    final regex = RegExp("^[a-zA-Z0-9]+");
    return regex.hasMatch(input);
  }
}
