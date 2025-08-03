import 'package:flutter/material.dart';

import '../../imports.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Color? color;
  final double? fontSize;
  final void Function()? onPressed;

  CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height ?? AppDimensions.buttonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            side: BorderSide(
              color:
                  onPressed == null ? Colors.grey : StaticColors.greyTextColor,
              width: 0.2,
            ),
            backgroundColor:
                onPressed == null ? Colors.grey : color ?? Color(0xff2a2635),
          ),
          child: Text(
            text,
            style: TextStyleBlueprint.style(context,
                color: onPressed == null ? Colors.grey : Colors.white,
                fontSize:fontSize?? 18.0,
                fontWeight: FontWeight.w400),
          ),
        ));
  }
}
