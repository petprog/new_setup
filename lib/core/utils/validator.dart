var regex = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);

class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email field cannot be empty";
    } else if (!regex.hasMatch(email)) {
      return "Invalid email address";
    } else {
      return null;
    }
  }

  static String? validateField(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Field cannot be empty";
    } else {
      return null;
    }
  }
}
