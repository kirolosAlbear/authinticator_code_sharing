import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_bridge/features/register_admin/data/models/register_page_args.dart';
import 'package:key_bridge/imports.dart';


class LoginPage extends BaseStatefulPage {
  final LoginPageArgs? args;

  const LoginPage({this.args, super.key});

  @override
  BaseState<LoginPage> createState() => _LoginPagePageState();
}

class _LoginPagePageState extends BaseState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formFieldKey = GlobalKey<FormState>();

  @override
  bool containPadding() => false;

  @override
  bool hasSideMenu() => widget.args?.isLoggingAgain ?? false;

  @override
  PreferredSizeWidget? appBar() => CustomAppbar(
        title: LocaleKeys.login.tr(),
        hasBackButton: widget.args?.isLoggingAgain,
      );

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      emailController.text = "program.gpt1@gmail.com";
      passwordController.text = "kiro123#";
    }
    if (widget.args == null) {
      getChosenAdmin().then(
        (EmailPasswordModel value) {
          if (value.email.isNotEmpty && value.password.isNotEmpty) {
            Routes.navigateToScreen(
                Routes.adminHomeScreen, NavigationType.goNamed, context);
          }
        },
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget body(BuildContext context) {
    return AuthenticationCardWidget(
      title: LocaleKeys.login.tr(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Form(
              key: formFieldKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: emailController,
                    validationMessage:
                        LocaleKeys.email_is_not_correct_format.tr(),
                    validationFunction: (p0) {
                      return CommonValidators.isValidEmail(p0 ??
                          ""); // Use the CommonValidators to validate email
                    },
                    labelText: LocaleKeys.email.tr(),
                  ),
                  const SizedBox(height: 15),

                  // Password
                  CustomTextField(
                    controller: passwordController,
                    isPasswordField: true,
                    validationFunction: (value) {
                      if (value?.isEmpty ?? true) {
                        return false;
                      } else {
                        return true;
                      }
                    },
                    validationMessage: LocaleKeys.password_should_have.tr(),
                    labelText: LocaleKeys.password.tr(),
                  )
                ],
              )),

          // SizedBox(height: 5),

          // Forgot password

          const SizedBox(height: 10),

          // Login button
          SizedBox(
              width: double.infinity,
              child: ParentBloc<LoginBloc, LoginState>(
                showWidgetOnError: true,
                listenerFunction: (context, state) async {
                  if (state.status == Status.success) {
                    if (state.loginResponseModel!.isAdmin) {
                      await CommonUtils.saveAdminUsernameAndPassword(
                          emailController.text, passwordController.text);

                      Routes.clearStack();
                      Routes.navigateToScreen(
                        Routes.adminHomeScreen,
                        NavigationType.pushReplacementNamed,
                        context,
                      );
                    } else {
                      final EmailPasswordModel userModel = EmailPasswordModel(
                          email: emailController.text,
                          password: passwordController.text);

                      await SharedPrefrencesService.getInstance().setString(
                          SharedPrefrencesKeys.normalUser,
                          userModel.toJson().toString());

                      Routes.navigateToScreen(
                        Routes.codeScreen,
                        NavigationType.goNamed,
                        context,
                      );
                    }
                    emailController.clear();
                    passwordController.clear();
                  }
                },
                builder: (state) {
                  return CustomElevatedButton(
                    onPressed: () {
                      print(emailController.text);
                      bool isValid = formFieldKey.currentState!.validate();

                      if (isValid) {
                        BlocProvider.of<LoginBloc>(context).add(getLoginEvent(
                            LoginRequestModel(
                                email: emailController.text.trim(),
                                password: passwordController.text)));
                      }
                    },
                    text: LocaleKeys.login.tr(),
                  );
                },
              )),

          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Routes.navigateToScreen(
                Routes.registerAdminScreen,
                NavigationType.pushNamed,
                extra: RegisterPageArgs(
                    isLoggingAgain: widget.args?.isLoggingAgain ?? false),
                context,
              );
            },
            child: Text(
              LocaleKeys.register_as_admin.tr(),
              style: AppTextStyles.bold_14_black(context).copyWith(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                decorationColor: Colors.white,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
