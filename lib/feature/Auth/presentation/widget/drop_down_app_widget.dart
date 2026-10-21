// import 'package:flutter/material.dart';
// import 'package:uniflow/core/color/app_colors.dart';

// class DropDownAppWidget extends StatelessWidget {
//   const DropDownAppWidget({
//     super.key,
//     required BoxDecoration boxDecoration,
//     required this.hint,
//     required this.icon,
//     this.value,
//     required this.items,
//     required this.onChanged,
//   }) : _boxDecoration = boxDecoration;

//   final BoxDecoration _boxDecoration;
//   final String hint;
//   final IconData icon;
//   final String? value;
//   final List<String> items;
//   final ValueChanged<String?> onChanged;
//   //   required String hint,
//   //   required IconData icon,
//   //   required String? value,
//   //   required List<String> items,
//   //   required ValueChanged<String?> onChanged,
//   // @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       padding: const EdgeInsets.only(left: 18, right: 16),
//       decoration: _boxDecoration,
//       child: Row(
//         children: [
//           Icon(icon, color: AppColors.text, size: 22),
//           const SizedBox(width: 12),
//           Expanded(
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 value: value,
//                 isExpanded: true,
//                 hint: Text(
//                   hint,
//                   style: const TextStyle(fontSize: 13.5, color: AppColors.text),
//                 ),
//                 icon: const Icon(
//                   Icons.keyboard_arrow_down,
//                   color: AppColors.text,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 style: const TextStyle(fontSize: 13.5, color: AppColors.text),
//                 items: items
//                     .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                     .toList(),
//                 onChanged: onChanged,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';

class DropDownAppWidget extends StatefulWidget {
  const DropDownAppWidget({
    super.key,
    required this.boxDecoration,
    required this.hint,
    required this.icon,
    this.value,
    required this.items,
    required this.onChanged,
  });

  final BoxDecoration boxDecoration;
  final String hint;
  final IconData icon;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  State<DropDownAppWidget> createState() => _DropDownAppWidgetState();
}

class _DropDownAppWidgetState extends State<DropDownAppWidget> {
  // القيمة المختارة داخل الـ Widget نفسه
  String? selectedValue;

  @override
  void initState() {
    super.initState();

    // تعيين القيمة الابتدائية إن وُجدت
    selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant DropDownAppWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // تحديث القيمة إذا تغيّرت من الـ Parent
    if (oldWidget.value != widget.value) {
      selectedValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 18, right: 16),
      decoration: widget.boxDecoration,
      child: Row(
        children: [
          Icon(widget.icon, color: AppColors.text, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                hint: Text(
                  widget.hint,
                  style: const TextStyle(fontSize: 13.5, color: AppColors.text),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.text,
                ),
                borderRadius: BorderRadius.circular(16),
                style: const TextStyle(fontSize: 13.5, color: AppColors.text),
                items: widget.items
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    // تحديث القيمة وإظهارها مباشرة
                    selectedValue = newValue;
                  });

                  // إشعار الـ Parent بالاختيار
                  widget.onChanged(newValue);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
