import 'package:flutter/material.dart';

extension OnString on String {
  Text get txt => Text(this);

  String get extensionPath {
    return split(".").last;
  }

  /// capitalize first letter
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// capitalize first letter of each word
  String capitalizeWords() {
    return split(' ').map((str) => str.capitalize()).join(' ');
  }

  /// capitalize first letter of each sentence
  String capitalizeSentences() {
    return split('. ').map((str) => str.capitalize()).join('. ');
  }

  /// add space between each character
  String addSpaceBetweenCharacters() {
    return split('').join(' ');
  }

  // reverse string
  String reverse() {
    return split('').reversed.join();
  }

  /// remove all spaces
  String removeAllSpaces() {
    return replaceAll(' ', '');
  }

  /// remove all special characters
  String removeAllSpecialCharacters() {
    return replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  /// count of words without spaces
  int get wordCount {
    return split(' ').length;
  }

  /// count of characters without spaces
  int get characterCount {
    return removeAllSpaces().length;
  }

  /// count of lines
  int get lineCount {
    return split('\n').length;
  }
}

extension StringVaildation on String {
// vaildation for Strings

  String? get validatePhoneNumber {
    // Regular expression pattern for a basic 10-digit phone number
    // Adjust the pattern based on your specific phone number format
    String pattern = r'^[0-9]{10}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(this)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? get validateUsername {
    // Regular expression pattern for a basic username validation
    // Adjust the pattern based on your specific requirements
    String pattern = r'^[a-zA-Z0-9_-]{3,20}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(this)) {
      return 'Username must be 3-20 characters long and can only contain letters, numbers, underscores, and hyphens';
    }
    return null;
  }

  String? get validateEmail {
    // Regular expression pattern for a basic email validation
    // This is a simple pattern, consider using a more comprehensive one for production
    String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(this)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? get validatePassword {
    if (isEmpty) {
      return 'Please enter a password';
    }
    if (length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check for uppercase, lowercase, digit, and special character
    bool hasUppercase = contains(RegExp(r'[A-Z]'));
    bool hasLowercase = contains(RegExp(r'[a-z]'));
    bool hasDigit = contains(RegExp(r'[0-9]'));
    bool hasSpecialChar = contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUppercase || !hasLowercase || !hasDigit || !hasSpecialChar) {
      return 'Password must include at least one uppercase letter, one lowercase letter, one digit, and one special character';
    }

    return null;
  }
}
