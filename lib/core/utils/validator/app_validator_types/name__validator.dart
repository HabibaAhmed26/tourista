import 'package:tourista/core/utils/app_strings.dart';
import 'package:tourista/core/utils/validator/app_Validator.dart';
import 'package:tourista/core/utils/validator/reg_exp.dart';

class NameValidator extends AppValidator {
  NameValidator({super.initValue});
  @override
  List<String> check() {
    List<String> reasons = [];

    if (value.isEmpty) {
      reasons.add(AppStrings.nameIsValid);
    }
    if (AppRegExp.specialCharacters.hasMatch(value)) {
      reasons.add(AppStrings.nameNotValid);
    }
    if (AppRegExp.numbers.hasMatch(value)) {
      reasons.add(AppStrings.nameNotValid);
    }
    if (AppRegExp.space.hasMatch(value)) {
      reasons.add(AppStrings.nameNotValid);
    }
    if (AppRegExp.capitalLetter.hasMatch(value) &&
        !AppRegExp.capitalFirstLetter.hasMatch(value)) {
      reasons.add(AppStrings.nameNotValid);
    }
    if (!AppRegExp.capitalFirstLetter.hasMatch(value)) {
      reasons.add(AppStrings.nameNoFirstCapital);
    }
    return reasons;
  }
}
