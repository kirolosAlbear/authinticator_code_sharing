import 'package:key_bridge/config/dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:key_bridge/core/widgets/custom_card_widget.dart';

class AuthenticationCardWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final double? maxWidth;

  const AuthenticationCardWidget(
      {super.key, required this.title, required this.child, this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 25, end: 25, top: 25),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ??
              AppDimensions
                  .cardMaxWidth, // Set a maximum width for the container

          // Set a maximum width for the container
        ),
        child: CustomCardWidget(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,),
                ),
                SizedBox(height: 20),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
