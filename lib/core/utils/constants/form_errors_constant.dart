import 'package:flutter/cupertino.dart';

class FormErrorsConstant {
  static Map<String, String> common = {
    'required': 'This field is required.',
    'invalid': 'This field has invalid value.'
  };

  static Map<String, String> email = {
    'required': 'Email is required.',
    'invalid': 'Please enter a valid email address'
  };

  static Map<String, String> password = {
    'required': 'Password is required.',
  };
}
