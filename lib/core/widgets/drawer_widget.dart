import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../imports.dart';

class DrawerWidget extends StatelessWidget {
  final bool showOnlyLogout;
  final bool isSideMenu;
  const DrawerWidget(
      {super.key, required this.showOnlyLogout, this.isSideMenu = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StaticColors.sideMenuColor,
        border: isSideMenu
            ? null
            : Border(
                right: BorderSide(
                  color: StaticColors.greyTextColor,
                  width: 0.5,
                ),
              ),
      ),
      child: SingleChildScrollView(
        child: Material(
          color: Colors.transparent,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.sp,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              showOnlyLogout == true
                  ? const SizedBox()
                  : Container(
                      decoration: const BoxDecoration(
                        color: StaticColors.sideMenuHeaderColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.Welcome_Admin.tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.account_circle_outlined,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  Constants.chosenAdmin.email,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showOnlyLogout == true
                      ? const SizedBox()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.home_outlined,
                                color: Colors.white,
                              ),
                              title: _buildTitle(
                                LocaleKeys.home.tr(),
                              ),
                              titleAlignment: ListTileTitleAlignment.center,
                              subtitle: _buildSubTitle(
                                LocaleKeys.Go_to_home_page.tr(),
                              ),
                              onTap: () {
                                Routes.navigateToScreen(Routes.adminHomeScreen,
                                    NavigationType.goNamed, context);
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context); // Closes the drawer
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.app_registration_outlined,
                                color: Colors.white,
                              ),
                              title: _buildTitle(LocaleKeys.add_user.tr()),
                              subtitle:
                                  _buildSubTitle(LocaleKeys.Add_new_user.tr()),
                              onTap: () {
                                Routes.navigateToScreen(
                                        Routes.registerUserScreen,
                                        NavigationType.pushNamed,
                                        context)
                                    .then(
                                  (value) {
                                    BlocProvider.of<AdminHomeBloc>(context)
                                        .add(getAdminHomeEvent(
                                      requestModel: AdminHomeRequestModel(
                                        email: Constants.chosenAdmin.email,
                                        password:
                                            Constants.chosenAdmin.password,
                                      ),
                                    ));
                                  },
                                );
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context); // Closes the drawer
                                } // Closes the drawer
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.perm_identity_rounded,
                                color: Colors.white,
                              ),
                              title: _buildTitle(LocaleKeys.profile.tr()),
                              subtitle: _buildSubTitle(
                                  LocaleKeys.Go_to_profile_page.tr()),
                              onTap: () {
                                Routes.navigateToScreen(Routes.profileScreen,
                                    NavigationType.pushNamed, context);

                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context); // Closes the drawer
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.login,
                                color: Colors.white,
                              ),
                              title: _buildTitle(LocaleKeys.login.tr()),
                              subtitle: _buildSubTitle(
                                  LocaleKeys.Login_with_other_account.tr()),
                              onTap: () {
                                Routes.navigateToScreen(Routes.loginScreen,
                                    NavigationType.pushNamed, context,
                                    extra: LoginPageArgs(isLoggingAgain: true));
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context); // Closes the drawer
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.switch_account_outlined,
                                color: Colors.white,
                              ),
                              title:
                                  _buildTitle(LocaleKeys.Switch_Account.tr()),
                              subtitle: _buildSubTitle(
                                  LocaleKeys.Switch_to_another_account.tr()),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                        child: const SwitchAccountWidget());
                                  },
                                );
                              },
                            ),
                            const Divider(
                              thickness: 0.5,
                            ),
                          ],
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                        ),
                        title: _buildTitle(LocaleKeys.Log_Out.tr()),
                        subtitle: _buildSubTitle(
                            LocaleKeys.Sign_out_of_all_your_accounts.tr()),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return CustomOkCancelDialog(
                                  onOkPressed: () async {
                                await SharedPrefrencesService.getInstance()
                                    .clear();
                                Routes.clearStack();
                                Routes.navigateToScreen(
                                    Routes.loginScreen,
                                    NavigationType.goNamed,
                                    context); // Closes the drawer
                              });
                            },
                          );
                        },
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 3),
                        child: Text(
                          version,
                          style: GoogleFonts.libreBaskerville(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: StaticColors.greyTextColor,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildSubTitle(String title) {
    return Text(
      title,
      style: const TextStyle(color: StaticColors.greyTextColor),
    );
  }
}
