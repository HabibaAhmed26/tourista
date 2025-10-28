import 'package:tourista/core/utils/app_strings.dart';
import 'package:tourista/core/utils/validator/app_Validator.dart';
import 'package:tourista/core/utils/validator/reg_exp.dart';

class EmailAppValidator extends AppValidator {
  EmailAppValidator({super.initValue});
  @override
  List<String> check() {
    List<String> reasons = [];

    if (value.isEmpty) {
      reasons.add(AppStrings.emailIsValid);
    }
    if (!AppRegExp.email.hasMatch(value)) {
      reasons.add(AppStrings.emailNotValid);
    }
    return reasons;
  }
}
