import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/theme_data.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  final String? Function(String?)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: backGroundColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            onChanged: onChanged,
            keyboardType: TextInputType.streetAddress,
            cursorColor: backGroundColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: backGroundColor,
                ),
              ),
              fillColor: accentColor.withOpacity(0.2),
              filled: true,
              isDense: true,
              prefixIcon: Icon(
                Icons.search,
                size: 25.sp,
                color: accentColor,
              ),
              hintText: "Search title, date...",
              hintStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: whiteColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
