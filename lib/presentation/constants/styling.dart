import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ranks_test_weather_app/presentation/constants/colors.dart';

class Styling {
  static double roundedBorderRadius() {
    return 32.r;
  }

  static double screenPadding() {
    return 16.w;
  }

  static double almostTransparentContainerOpacity() => 0.15;

  static Container screenGradient(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CustomColors.homeScreenGradientStartColor,
            Theme.of(context).primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }

  static TextStyle transparentTitleTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 12.sp,
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
    );
  }
}
