import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(202, 255, 143, 102),
              AppColors.backgroundLittelOrange,
              AppColors.backgroundDisabled,
            ],
          ),
        ),
        child: Column(
          spacing: 1,
          children: [
            // Spacer(),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.appBarBlack,
              ),
            ),
            Text(
              'UniFlow',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
