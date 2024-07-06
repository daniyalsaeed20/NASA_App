import 'package:flutter/material.dart';

import '../utils/theme_data.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text,this.icon});

  final void Function()? onPressed;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(color: backGroundColor),
          ),
          if(icon!=null)
          Icon(icon)
        ],
      ),
    );
  }
}
