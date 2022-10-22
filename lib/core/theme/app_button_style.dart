import 'package:flutter/material.dart';

class AppButtonStyles {
  static ButtonStyle filled(context) => ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));

  static filledTonal(context) => ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
}
