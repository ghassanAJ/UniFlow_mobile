import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/ds_theme.dart';
import 'package:uniflow/core/design/widgets/ds_chip.dart';

/// Horizontal single-select chips.
///
/// Pass [selectedIndex] to control it. Omit it and the bar keeps its own index.
class DsChoiceBar extends StatefulWidget {
  const DsChoiceBar({
    super.key,
    required this.options,
    this.selectedIndex,
    this.initialIndex = 0,
    this.onChanged,
    this.padding = EdgeInsets.zero,
  });

  final List<String> options;
  final int? selectedIndex;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final EdgeInsetsGeometry padding;

  @override
  State<DsChoiceBar> createState() => _DsChoiceBarState();
}

class _DsChoiceBarState extends State<DsChoiceBar> {
  late int _index = _clamp(widget.initialIndex);

  int _clamp(int index) {
    if (widget.options.isEmpty) return 0;
    return index.clamp(0, widget.options.length - 1);
  }

  int get _selected => _clamp(widget.selectedIndex ?? _index);

  @override
  void didUpdateWidget(covariant DsChoiceBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _index = _clamp(_index);
  }

  void _select(int index) {
    if (widget.selectedIndex == null && _index != index) {
      setState(() => _index = index);
    }
    widget.onChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.options.isEmpty) return const SizedBox.shrink();

    final ds = context.ds;
    final colors = ds.colors;
    final selected = _selected;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: widget.padding,
      child: Row(
        children: [
          for (var i = 0; i < widget.options.length; i++) ...[
            if (i > 0) SizedBox(width: ds.chips.gap.w),
            DsChip(
              label: widget.options[i],
              size: DsChipSize.lg,
              selected: selected == i,
              backgroundColor: selected == i ? null : colors.primarySoft,
              foregroundColor: selected == i ? null : colors.chipForeground,
              onTap: () => _select(i),
              shadow: selected == i
                  ? [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: 0.35),
                        blurRadius: 12.r,
                        offset: Offset(0, 4.h),
                      ),
                    ]
                  : const <BoxShadow>[],
            ),
          ],
        ],
      ),
    );
  }
}
