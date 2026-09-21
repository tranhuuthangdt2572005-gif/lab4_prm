import 'package:flutter/material.dart';

/// Exercise 4: App Structure with Scaffold, AppBar, FAB & Theme
/// Goal: Practice building a complete screen structure.
/// - Demonstrates Scaffold properties: AppBar, Body, FloatingActionButton
/// - Demonstrates ThemeData customization (Colors, CardTheme, FloatingActionButtonTheme)
/// - Implements a Dark Mode toggle using ThemeMode
class AppStructureThemeDemo extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;

  const AppStructureThemeDemo({
    super.key,
    required this.themeModeNotifier,
  });

  @override
  State<AppStructureThemeDemo> createState() => _AppStructureThemeDemoState();
}

class _AppStructureThemeDemoState extends State<AppStructureThemeDemo> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleDarkMode() {
    if (widget.themeModeNotifier.value == ThemeMode.dark) {
      widget.themeModeNotifier.value = ThemeMode.light;
    } else {
      widget.themeModeNotifier.value = ThemeMode.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // 1. AppBar Structure
      appBar: AppBar(
        title: const Text('Exercise 4 – App Structure & Theme'),
        actions: [
          IconButton(
            tooltip: 'Toggle Dark/Light Mode',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleDarkMode,
          ),
        ],
      ),

      // 2. Body Structure
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Theme Mode Status Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      isDark ? Icons.nightlight_round : Icons.wb_sunny,
                      size: 48,
                      color: isDark ? Colors.amberAccent : Colors.orange,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isDark ? 'Dark Mode Active' : 'Light Mode Active',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Theme is controlled globally via ThemeMode and customized ThemeData.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    // Dark Mode Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Light'),
                        const SizedBox(width: 8),
                        Switch(
                          value: isDark,
                          onChanged: (val) => _toggleDarkMode(),
                        ),
                        const SizedBox(width: 8),
                        const Text('Dark'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Scaffold Demonstration Section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scaffold Components Highlight',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Divider(),
                    const ListTile(
                      dense: true,
                      leading: Icon(Icons.dashboard_outlined),
                      title: Text('Scaffold'),
                      subtitle: Text('Provides basic Material design visual layout structure.'),
                    ),
                    const ListTile(
                      dense: true,
                      leading: Icon(Icons.web_asset),
                      title: Text('AppBar'),
                      subtitle: Text('Displays toolbar, screen title, and top action buttons.'),
                    ),
                    const ListTile(
                      dense: true,
                      leading: Icon(Icons.view_agenda_outlined),
                      title: Text('Body'),
                      subtitle: Text('The primary content area rendered below the AppBar.'),
                    ),
                    const ListTile(
                      dense: true,
                      leading: Icon(Icons.touch_app_outlined),
                      title: Text('FloatingActionButton (FAB)'),
                      subtitle: Text('Primary circular call-to-action pinned at the bottom-right.'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // FAB Interaction Result Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'FAB Click Counter',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Tap the (+) FAB to increment',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$_counter',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 3. FloatingActionButton Structure
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
