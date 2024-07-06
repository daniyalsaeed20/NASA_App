import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/theme_data.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      margin: EdgeInsets.symmetric(
        vertical: verticalMargin,
        horizontal: horizontalMargin,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: foreGroundColor,
      ),
      child: CircularProgressIndicator(
        backgroundColor: backGroundColor,
        color: accentColor,
        strokeWidth: 2.5.r,
      ),
    );
  }
}
