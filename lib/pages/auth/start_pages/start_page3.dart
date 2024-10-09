import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class StartPage3 extends StatelessWidget {
  const StartPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: ColorPalette.backgroundGradient, // Use your predefined gradient
        ),
        child: Column(
          children: [
            Image.asset(
              "assets/images/icons/friendss.png",
              height: 450,
              width: 450,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          "Ready to begin? Click 'Get Started' to create your pet's perfect stay with us!",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.accentBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/login", (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPalette.secondary,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            color: ColorPalette.accentBlack,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    // Add more space below the button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40), // Adjust spacing here
                      child: Center(
                        child: Container(
                          width: 95,
                          height: 25,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 35,
                                top: 0,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: const ShapeDecoration(
                                    color: ColorPalette.greyish,
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 70,
                                top: 0,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: const ShapeDecoration(
                                    color: ColorPalette.accentWhite,
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: const ShapeDecoration(
                                    color: ColorPalette.greyish,
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
