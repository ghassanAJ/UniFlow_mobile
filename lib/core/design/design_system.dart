/// UniFlow design system.
///
/// Tokens live on [ThemeData] and widgets read them through `context.ds`.
/// Override a whole subtree with [DsTheme], or a single widget with its
/// constructor (`color`, `radius`, `variant`, `role`, ...).
///
/// ```dart
/// DsButton(label: 'Enroll', onPressed: () {})
///
/// DsTheme(
///   colors: context.ds.colors.copyWith(primary: const Color(0xFF2457C5)),
///   child: const CoursesScreen(),
/// )
/// ```
library;

export 'app_spacing.dart';
export 'ds_theme.dart';
export 'tokens/button_tokens.dart';
export 'tokens/card_tokens.dart';
export 'tokens/chip_tokens.dart';
export 'tokens/color_tokens.dart';
export 'tokens/field_tokens.dart';
export 'tokens/icon_button_tokens.dart';
export 'tokens/typography_tokens.dart';
export 'widgets/ds_badge.dart';
export 'widgets/ds_button.dart';
export 'widgets/ds_card.dart';
export 'widgets/ds_chip.dart';
export 'widgets/ds_choice_bar.dart';
export 'widgets/ds_icon_button.dart';
export 'widgets/ds_search_field.dart';
export 'widgets/ds_section_header.dart';
export 'widgets/ds_text.dart';
export 'widgets/ds_text_field.dart';
export 'package:uniflow/core/widget/avatar_widget.dart';
