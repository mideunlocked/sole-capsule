class CheckPassword {
  static bool checkPasswordStrength(String password) {
    // Define regular expressions for uppercase, lowercase, and special characters
    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp lowercaseRegex = RegExp(r'[a-z]');
    RegExp specialRegex = RegExp(
        r'[^a-zA-Z0-9]'); // Matches any character that is not alphanumeric

    // Check if password contains at least one uppercase letter, one lowercase letter, and one special character
    bool hasUppercase = uppercaseRegex.hasMatch(password);
    bool hasLowercase = lowercaseRegex.hasMatch(password);
    bool hasSpecial = specialRegex.hasMatch(password);

    return hasUppercase && hasLowercase && hasSpecial;
  }
}
