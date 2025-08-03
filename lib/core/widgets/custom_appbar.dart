import 'package:flutter/material.dart';
import 'package:key_bridge/imports.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? hasBackButton;
  final double _iconSize = 20;

  const CustomAppbar(
      {super.key, required this.title, this.hasBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: StaticColors.greyTextColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (hasBackButton == null)
              ? const SizedBox(width: 8)
              : const SizedBox(
                  width: 0,
                ),
          hasBackButton == null
              ? const SizedBox()
              : MediaQuery.of(context).size.width >
                      AppDimensions.mobileScreenWidth
                  ? SizedBox(
                      width: 10,
                    )
                  : hasBackButton!
                      ? IconButton(
                          padding: const EdgeInsets.all(0),
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: _iconSize,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                        )
                      : IconButton(
                          padding: const EdgeInsets.all(0),
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: _iconSize,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
          // const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 3,
                ),
                SizedBox(
                    width: 90,

                    child: Image.asset(Assets.images.png.logo.path)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // language switcher
                      PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        onSelected: (value) {
                          if (value ==
                              SharedPrefrencesKeys.englishLanguageKey) {
                            EasyLocalization.of(context)!.setLocale(
                                const Locale(
                                    SharedPrefrencesKeys.englishLanguageKey));
                            SharedPrefrencesService.getInstance().setString(
                              SharedPrefrencesKeys.languageKey,
                              SharedPrefrencesKeys.englishLanguageKey,
                            );
                          } else if (value ==
                              SharedPrefrencesKeys.arabicLanguageKey) {
                            EasyLocalization.of(context)!.setLocale(
                                const Locale(
                                    SharedPrefrencesKeys.arabicLanguageKey));

                            SharedPrefrencesService.getInstance().setString(
                              SharedPrefrencesKeys.languageKey,
                              SharedPrefrencesKeys.arabicLanguageKey,
                            );
                          }
                        },
                        color: StaticColors.backgroundColor,
                        elevation: 10,
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'en',
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            child: Row(
                              children: [
                                Text('🇺🇸'),
                                SizedBox(width: 8),
                                Text(
                                  'English',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'ar',
                            child: Row(
                              children: [
                                Text('🇪🇬'),
                                SizedBox(width: 8),
                                Text(
                                  'العربية',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
