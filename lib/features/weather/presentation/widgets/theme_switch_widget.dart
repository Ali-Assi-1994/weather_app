import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/utils/theme/theme_notifier.dart';

class ThemeSwitchWidget extends ConsumerWidget {
  const ThemeSwitchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(Icons.dark_mode),
        Switch(
          value: ref.watch(themeNotifierProvider) == ThemeMode.light,
          onChanged: (value) => ref.watch(themeNotifierProvider.notifier).toggleTheme(),
        ),
        const Icon(Icons.light_mode),
        const SizedBox(width: 16),
      ],
    );
  }
}
