import 'package:flutter/material.dart';
import 'package:kahel/constants/colors.dart';

class LandingButton extends StatelessWidget {
  final String buttonName;
  final String filePath;
  final VoidCallback onTap;
  final double iconHeight;
  final double iconWidth;
  const LandingButton(
      {super.key,
      required this.buttonName,
      required this.filePath,
      required this.onTap,
      required this.iconHeight,
      required this.iconWidth});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          decoration: BoxDecoration(
            color: ColorPalette.accentWhite,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(
                  0,
                  2,
                ),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                filePath,
                height: iconHeight,
                width: iconWidth,
                color: ColorPalette.primary,
              ),
              const SizedBox(width: 3),
              Text(
                buttonName,
                style: const TextStyle(
                  color: ColorPalette.accentBlack,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
