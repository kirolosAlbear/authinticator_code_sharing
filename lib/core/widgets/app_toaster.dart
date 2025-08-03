import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:key_bridge/imports.dart';

enum AppToastType { success, error, warning }

class AppToast {
  static final FToast fToast = FToast();

  static void showToast(String message,
      {BuildContext? context,
      AppToastType type = AppToastType.error,
      bool isThereNavBar = false}) {
    if (context != null) fToast.init(context);

    Color color = type == AppToastType.error
        ? const Color(0xffFCE6E8)
        : type == AppToastType.success
            ? const Color(0xffE7F8EB)
            : const Color(0xffFCF6E4);
    fToast.showToast(
      child: _toastContainer(message, color, type, context),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 10),
    );
  }

  static Widget _toastContainer(String message, Color color, AppToastType type,
          BuildContext? context) =>
      Container(
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxWidth: 300.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 5.0,
              offset: const Offset(0, 3),
            ),
          ],
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (type == AppToastType.error)
                    SizedBox(
                        height: 20,
                        width: 20,
                        child:
                            SvgPicture.asset(Assets.images.svg.toastErrorIcon))
                  else
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                            Assets.images.svg.toastSuccessIcon)),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      message,
                      style: TextStyle(
                          fontSize: AppDimensions.getFonTSize14,
                          fontWeight: TextStyleBlueprint.regularFontWeight,
                          color: StaticColors.black_735),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              width: 20,
              height: 20,
              child: InkWell(
                onTap: () {
                  //hide toast
                  fToast.removeCustomToast();
                },
                child: const Icon(
                  Icons.close,
                  size: 20,
                  color: StaticColors.black_735,
                ),
              ),
            ),
          ],
        ),
      );
}
