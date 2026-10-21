import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';

class YearSelectorWidget extends StatefulWidget {
  const YearSelectorWidget({super.key});

  @override
  State<YearSelectorWidget> createState() => _YearSelectorWidgetState();
}

class _YearSelectorWidgetState extends State<YearSelectorWidget> {
  @override
    int _year = 0;
      final _years = const ['1st', '2nd', '3rd', '4th', '5th'];
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_years.length, (i) {
        final selected = i == _year;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _year = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 42,
              margin: EdgeInsets.only(right: i == _years.length - 1 ? 0 : 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: const Color.fromARGB(
                            255,
                            0,
                            0,
                            0,
                          ).withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Text(
                _years[i],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : AppColors.text,
                ),
              ),
            ),
          ),
        );
      }),
    );;
  }
}