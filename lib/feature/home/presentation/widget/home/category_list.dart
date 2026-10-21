import 'package:flutter/material.dart';
import 'package:uniflow/feature/home/data/model/models.dart';
// import '../../models/models.dart';
import 'category_chip.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  final List<CategoryItem> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => CategoryChip(
          label: categories[i].label,
          icon: categories[i].icon,
          isSelected: i == selectedIndex,
          onTap: () => onSelected(i),
        ),
      ),
    );
  }
}
