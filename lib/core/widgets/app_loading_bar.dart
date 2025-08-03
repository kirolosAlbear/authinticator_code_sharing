import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../imports.dart';

class AppLoadingBar extends StatelessWidget {
  const AppLoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
            color: StaticColors.primaryLighterColor, size: 50));
  }
}
