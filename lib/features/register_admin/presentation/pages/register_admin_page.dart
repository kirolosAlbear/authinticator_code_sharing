import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:key_bridge/features/register_admin/data/models/register_page_args.dart';
import 'package:key_bridge/imports.dart';

class RegisterAdminPage extends BaseStatefulPage {
  final RegisterPageArgs? args;
  RegisterAdminPage({super.key, required this.args});

  @override
  State<RegisterAdminPage> createState() => _RegisterAdminPageState();
}

class _RegisterAdminPageState extends BaseState<RegisterAdminPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController secretKeyController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);

  final ValueNotifier<bool> isConfirmPasswordVisible = ValueNotifier(false);

  final GlobalKey<FormState> formFieldKey = GlobalKey<FormState>();

  @override
  PreferredSizeWidget? appBar() => CustomAppbar(
        title: LocaleKeys.register.tr(),
      );

  @override
  bool hasSideMenu() => widget.args?.isLoggingAgain ?? false;

  @override
  bool containPadding() => false;

  @override
  Widget body(BuildContext context) {
    if (kDebugMode) {
      emailController.text = "program.gpt3@gmail.com";
      secretKeyController.text = "2XTVRQK4CFJBSSNHK5GSBPKGCVLQEGR";
      passwordController.text = "kiro123#";
      confirmPasswordController.text = "kiro123#";
    }
    return AuthenticationCardWidget(
      title: LocaleKeys.register.tr(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Name
          Form(
            key: formFieldKey,
            child: Column(
              children: [
                // Email
                CustomTextField(
                  controller: emailController,
                  validationMessage:
                      LocaleKeys.email_is_not_correct_format.tr(),
                  validationFunction: (p0) {
                    return CommonValidators.isValidEmail(p0 ?? "");
                  },
                  labelText: LocaleKeys.email.tr(),
                ),
                SizedBox(height: 15),

                CustomTextField(
                  controller: secretKeyController,
                  labelText: LocaleKeys.scan_your_secret_key.tr(),
                  isScannerField: true,
                ),
                SizedBox(height: 15),

                // Password
                CustomTextField(
                  controller: passwordController,
                  isPasswordField: true,
                  validationMessage: LocaleKeys.password_should_have.tr(),
                  validationFunction: (p0) {
                    return CommonValidators.isValidPassword(p0 ?? "");
                  },
                  labelText: LocaleKeys.password.tr(),
                ),
                SizedBox(height: 15),

                // Confirm Password
                CustomTextField(
                  controller: confirmPasswordController,
                  isPasswordField: true,
                  labelText: LocaleKeys.confirm_password.tr(),
                  validationMessage: LocaleKeys.passwords_do_not_match.tr(),
                  validationFunction: (String? p0) {
                    if (p0 != passwordController.text) {
                      return false;
                    } else {
                      return true;
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Submit button
          SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                onPressed: () async {
                  if (formFieldKey.currentState!.validate()) {
                    Routes.navigateToScreen(
                        Routes.otpScreen, NavigationType.pushNamed, context,
                        extra: OtpPageArgs(
                            registerAdminRequestModel:
                                RegisterAdminRequestModel(
                          verificationCode: "",
                          secretKey: secretKeyController.text,
                          adminUserName: emailController.text,
                          adminPassword: passwordController.text,
                        )));
                  }
                },
                text: (LocaleKeys.register.tr()),
              )),
        ],
      ),
    );
  }
}
