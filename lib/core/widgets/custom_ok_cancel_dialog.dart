import 'package:flutter/material.dart';
import 'package:key_bridge/imports.dart';

class CustomOkCancelDialog extends StatelessWidget {
  final Function onOkPressed;

  const CustomOkCancelDialog({required this.onOkPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: StaticColors.backgroundColor,
      title: Text(
        LocaleKeys.confirmation.tr(),
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        LocaleKeys.are_you_sure.tr(),
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      actions: <Widget>[

        CustomElevatedButton(
          height: 35,
          fontSize: 16,
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          text: LocaleKeys.cancel.tr(),
        ),

        CustomElevatedButton(
          height: 35,
          color: Color(0xff6f41ce),
          fontSize: 16,
          
          onPressed: () {
            // Perform the action here
            onOkPressed();
            Navigator.of(context).pop(); // Close the dialog
          },
          text: LocaleKeys.ok.tr(),
        ),

        // TextButton(
        //   onPressed: () {
        //     Navigator.of(context).pop(); // Close the dialog
        //   },
        //   child: Text(LocaleKeys.cancel.tr(),
        //       style: TextStyle(color: StaticColors.primaryLighterColor),),
        // ),

      ],
    );
  }
}
