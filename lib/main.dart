import 'package:flutter/material.dart';

import 'exercises/app_structure_theme_demo.dart';
import 'exercises/common_ui_fixes_demo.dart';
import 'exercises/core_widgets_demo.dart';
import 'exercises/input_controls_demo.dart';
import 'exercises/layout_demo.dart';

void main() {
  runApp(const Lab4App());
}

/// Global ValueNotifier to handle dynamic ThemeMode switching (Light / Dark)
final ValueNotifier<ThemeMode> globalThemeMode = ValueNotifier(ThemeMode.light);

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: globalThemeMode,
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: 'Lab 4 – Flutter UI Fundamentals',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,

          // Light ThemeData Customization
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF5E60CE),
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: const Color(0xFFF7F7FA),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black87,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            cardTheme: CardThemeData(
              elevation: 0.5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          // Dark ThemeData Customization
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF5E60CE),
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF121216),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            cardTheme: CardThemeData(
              elevation: 0.5,
              color: const Color(0xFF1E1E24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          home: const MainMenuScreen(),
        );
      },
    );
  }
}

/// Home Navigation Screen matching Picture1.png
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Exercise 1 – Core Widgets Demo',
        'builder': (context) => const CoreWidgetsDemo(),
      },
      {
        'title': 'Exercise 2 – Input Controls Demo',
        'builder': (context) => const InputControlsDemo(),
      },
      {
        'title': 'Exercise 3 – Layout Demo',
        'builder': (context) => const LayoutDemo(),
      },
      {
        'title': 'Exercise 4 – App Structure & Theme',
        'builder': (context) =>
            AppStructureThemeDemo(themeModeNotifier: globalThemeMode),
      },
      {
        'title': 'Exercise 5 – Common UI Fixes',
        'builder': (context) => const CommonUiFixesDemo(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 – Flutter UI Fundament...'),
        actions: [
          IconButton(
            tooltip: 'Toggle Theme',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode_outlined),
            onPressed: () {
              globalThemeMode.value =
                  isDark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          itemCount: menuItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Material(
              color: isDark
                  ? const Color(0xFF1E1E28)
                  : const Color(0xFFF3F3F9),
              borderRadius: BorderRadius.circular(14),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.04),
                    width: 1,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 6.0,
                ),
                title: Text(
                  item['title'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: isDark ? Colors.white54 : Colors.black54,
                  size: 22,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) =>
                          (item['builder'] as Widget Function(BuildContext))(
                              ctx),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
