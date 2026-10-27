import 'package:flutter/material.dart';
import 'package:uniflow/core/design/tokens/button_tokens.dart';
import 'package:uniflow/core/design/tokens/card_tokens.dart';
import 'package:uniflow/core/design/tokens/chip_tokens.dart';
import 'package:uniflow/core/design/tokens/color_tokens.dart';
import 'package:uniflow/core/design/tokens/field_tokens.dart';
import 'package:uniflow/core/design/tokens/icon_button_tokens.dart';
import 'package:uniflow/core/design/tokens/typography_tokens.dart';
import 'package:uniflow/core/widget/avatar_widget.dart';

/// Resolved design tokens for the nearest [Theme].
class DsThemeData {
  DsThemeData(this._theme);

  final ThemeData _theme;

  ColorTokens get colors =>
      _theme.extension<ColorTokens>() ?? ColorTokens.light;

  TypographyTokens get typography =>
      _theme.extension<TypographyTokens>() ?? TypographyTokens.standard;

  ButtonTokens get buttons =>
      _theme.extension<ButtonTokens>() ?? ButtonTokens.standard;

  CardTokens get cards => _theme.extension<CardTokens>() ?? CardTokens.standard;

  ChipTokens get chips => _theme.extension<ChipTokens>() ?? ChipTokens.standard;

  FieldTokens get fields =>
      _theme.extension<FieldTokens>() ?? FieldTokens.standard;

  IconButtonTokens get iconButtons =>
      _theme.extension<IconButtonTokens>() ?? IconButtonTokens.standard;

  AvatarTokens get avatars =>
      _theme.extension<AvatarTokens>() ?? const AvatarTokens();
}

extension DesignSystemContext on BuildContext {
  DsThemeData get ds => DsThemeData(Theme.of(this));
}

List<ThemeExtension<dynamic>> mergeThemeExtensions(
  ThemeData theme,
  List<ThemeExtension<dynamic>> overrides,
) {
  final merged = Map<Object, ThemeExtension<dynamic>>.from(theme.extensions);
  for (final extension in overrides) {
    merged[extension.type] = extension;
  }
  return List<ThemeExtension<dynamic>>.of(merged.values);
}

/// Overrides design tokens for [child] without touching the rest of the app.
///
/// ```dart
/// DsTheme(
///   colors: context.ds.colors.copyWith(primary: const Color(0xFF2457C5)),
///   buttons: context.ds.buttons.copyWith(radius: 12),
///   child: const EnrollButton(),
/// )
/// ```
class DsTheme extends StatelessWidget {
  const DsTheme({
    super.key,
    required this.child,
    this.colors,
    this.typography,
    this.buttons,
    this.cards,
    this.chips,
    this.fields,
    this.iconButtons,
    this.avatars,
  });

  final Widget child;
  final ColorTokens? colors;
  final TypographyTokens? typography;
  final ButtonTokens? buttons;
  final CardTokens? cards;
  final ChipTokens? chips;
  final FieldTokens? fields;
  final IconButtonTokens? iconButtons;
  final AvatarTokens? avatars;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        extensions: mergeThemeExtensions(theme, [
          ?colors,
          ?typography,
          ?buttons,
          ?cards,
          ?chips,
          ?fields,
          ?iconButtons,
          ?avatars,
        ]),
      ),
      child: child,
    );
  }
}
