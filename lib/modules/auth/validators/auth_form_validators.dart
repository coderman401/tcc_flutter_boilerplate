import 'package:tcc_flutter_boilerplate/core/utils/constants/form_errors_constant.dart';
import 'package:tcc_flutter_boilerplate/core/utils/extensions/string_extensions.dart';

class AuthFormValidators {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return FormErrorsConstant.email['required'];
    }
    if (!EmailValidator(value).isValidEmail()) {
      return FormErrorsConstant.email['invalid'];
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return FormErrorsConstant.password['required'];
    }

    return null;
  }
}
