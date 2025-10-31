import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourista/core/theme/app_colors.dart';
import 'package:tourista/core/theme/app_textStyles.dart';
import 'package:tourista/core/utils/app_strings.dart';
import 'package:tourista/core/utils/validator/app_validator_types/email_validator.dart';
import 'package:tourista/login.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';
import 'package:tourista/presentation/widgets/app_textfield.dart';
import 'package:tourista/presentation/widgets/pattern_container.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();

  final EmailAppValidator _emailValidator = EmailAppValidator();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: PatternContainer(
        child: Center(
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
                              AppStrings.resetPassword,
                              style: AppTextstyles.title,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(AppStrings.enterEmail),
                          //Email TextField
                          SizedBox(height: 20),
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
                          //Send button
                          ElevatedButton(
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
                              try {
                                if (_emailValidator.isValid) {
                                  await context
                                      .read<AuthenticationCubit>()
                                      .resetPassword(_emailController.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(AppStrings.emailSent),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(AppStrings.emailNotValid),
                                    ),
                                  );
                                }
                              } catch (e) {
                                //show error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())),
                                );
                              }
                            },
                            child: Text(
                              AppStrings.send,
                              style: TextStyle(color: AppColors.white),
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
