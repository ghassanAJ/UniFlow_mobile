import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/feature/Auth/presentation/screens/create_account_screen.dart';
import 'package:uniflow/feature/Auth/presentation/widget/primary_button_app.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.suffix,
    this.onChanged,
  });
  //  required TextEditingController controller,
  // required String hint,
  // required IconData icon,
  // bool obscure = false,
  // Widget? suffix,
  // ValueChanged<String>? onChanged,
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure = false;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 16, right: 6),
      decoration: _boxDecoration,
      child: Row(
        children: [
          // _iconBadge(icon),
          IconBadgeWidget(icon: icon),

          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: obscure,
              onChanged: onChanged,
              style: const TextStyle(fontSize: 14, color: AppColors.text),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: AppColors.hint, fontSize: 13),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }

  BoxDecoration get _boxDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 10,
        offset: const Offset(0, 3),
      ),
    ],
  );
}
