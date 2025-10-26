import 'package:tourista/core/utils/app_strings.dart';
import 'package:tourista/core/utils/validator/app_Validator.dart';

class ConfirmPasswordAppValidator extends AppValidator {
  ConfirmPasswordAppValidator({super.initValue});

  String _comparedWithPassword = "";

  set comparedWithPassword(password) {
    _comparedWithPassword = password;
    setValue(value);
  }

  @override
  List<String> check() {
    List<String> reasons = [];

    if (value != _comparedWithPassword) {
      reasons.add(AppStrings.passwordDontMatch);
    }

    return reasons;
  }
}
