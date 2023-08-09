import 'package:flutter/material.dart';
import 'package:usos/styles/colors.dart';
import 'package:usos/styles/images.dart';

import '../../../styles/dimensions.dart';

class SplashScreenForm extends StatelessWidget {
  const SplashScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UsosColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.circular), // Image border
              child: Image.asset(
                UsosImages.logo,
                scale: 5,
              ),
            ),
            Text(
              "USOS",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: UsosColors.white),
            )
          ],
        ),
      ),
    );
  }
}
