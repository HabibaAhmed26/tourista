import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourista/core/di/di.dart';
import 'package:tourista/core/models/user_model.dart';
import 'package:tourista/core/theme/app_colors.dart';
import 'package:tourista/core/theme/app_textStyles.dart';
import 'package:tourista/core/utils/app_assets.dart';
import 'package:tourista/core/utils/app_strings.dart';
import 'package:tourista/core/utils/validator/app_Validator.dart';
import 'package:tourista/core/utils/validator/app_validator_types/confirmpassword_validator.dart';
import 'package:tourista/core/utils/validator/app_validator_types/email_validator.dart';
import 'package:tourista/core/utils/validator/app_validator_types/name__validator.dart';
import 'package:tourista/core/utils/validator/app_validator_types/password_validator.dart';
import 'package:tourista/login.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';
import 'package:tourista/presentation/features/profile/profile.dart';
import 'package:tourista/presentation/widgets/app_textfield.dart';
import 'package:tourista/presentation/widgets/pattern_container.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //controllers and validators
  final TextEditingController _emailController = TextEditingController();
  final EmailAppValidator _emailValidator = EmailAppValidator();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final NameValidator _firstNameValidator = NameValidator();
  final NameValidator _lastNameValidator = NameValidator();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final PasswordAppValidator _passwordValidator = PasswordAppValidator();
  final ConfirmPasswordAppValidator _confirmPasswordValidator =
      ConfirmPasswordAppValidator();
  //aobscure password
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return PatternContainer(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: AppColors.lightBlue,
            ),
            constraints: BoxConstraints(
              maxHeight:
                  MediaQuery.of(context).size.height *
                  0.9, // Optional max height
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,

                        children: [
                          Center(
                            child: Text(
                              AppStrings.signup,
                              style: AppTextstyles.title,
                            ),
                          ),
                          SizedBox(height: 20),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AppTextField(
                                  controller: _firstname,
                                  hint: AppStrings.firstName,
                                  onChange: (value) {
                                    setState(() {
                                      _firstNameValidator.setValue(value);
                                    });
                                  },
                                  keyboardType: TextInputType.name,
                                  validator: _firstNameValidator,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  radius: 40,
                                ),
                                AppTextField(
                                  controller: _lastname,
                                  hint: AppStrings.lastName,
                                  onChange: (value) {
                                    setState(() {
                                      _lastNameValidator.setValue(value);
                                    });
                                  },
                                  keyboardType: TextInputType.name,
                                  validator: _lastNameValidator,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  radius: 40,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          AppTextField(
                            prefixIcon: Icon(
                              Icons.email,
                              color: AppColors.darkBlue,
                            ),
                            controller: _emailController,
                            hint: AppStrings.emailAddress,
                            onChange: (value) {
                              setState(() {
                                _emailValidator.setValue(value);
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            validator: _emailValidator,
                            width: MediaQuery.of(context).size.width * 0.9,
                            radius: 40,
                          ),
                          SizedBox(height: 5),
                          AppTextField(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.darkBlue,
                            ),
                            controller: _password,
                            hint: AppStrings.password,
                            onChange: (value) {
                              setState(() {
                                _passwordValidator.setValue(value);
                                _confirmPasswordValidator.comparedWithPassword =
                                    value;
                              });
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            obscureText: _obscurePassword,
                            keyboardType: TextInputType.visiblePassword,
                            validator: _passwordValidator,
                            width: MediaQuery.of(context).size.width * 0.9,
                            radius: 40,
                          ),
                          SizedBox(height: 5),
                          AppTextField(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.darkBlue,
                            ),
                            controller: _confirmPassword,
                            hint: AppStrings.confirmPassword,
                            onChange: (value) {
                              setState(() {
                                _confirmPasswordValidator.setValue(value);
                              });
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                            obscureText: _obscureConfirmPassword,
                            keyboardType: TextInputType.visiblePassword,
                            validator: _confirmPasswordValidator,
                            width: MediaQuery.of(context).size.width * 0.9,
                            radius: 40,
                          ),
                          SizedBox(height: 5),
                          BlocListener<
                            AuthenticationCubit,
                            AuthenticationState
                          >(
                            listener: (context, state) {
                              if (state is AuthenticationError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                              if (state is Authenticationloaded) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(),
                                  ),
                                );
                              }
                            },
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                              ),
                              onPressed: () async {
                                if (_firstNameValidator.isValid &&
                                    _lastNameValidator.isValid &&
                                    _emailValidator.isValid &&
                                    _passwordValidator.isValid &&
                                    _confirmPasswordValidator.isValid) {
                                  await context
                                      .read<AuthenticationCubit>()
                                      .signUp(
                                        AppUser(
                                          email: _emailController.text,
                                          firstName: _firstname.text,
                                          lastName: _lastname.text,
                                        ),
                                        _password.text,
                                      );
                                } else {
                                  //show error message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(AppStrings.signUpinvalid),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                AppStrings.signup,
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                AppStrings.backToLogIn,
                                style: TextStyle(color: AppColors.darkBlue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
