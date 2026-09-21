import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:login/exercises/app_structure_theme_demo.dart';
import 'package:login/exercises/common_ui_fixes_demo.dart';
import 'package:login/exercises/core_widgets_demo.dart';
import 'package:login/exercises/input_controls_demo.dart';
import 'package:login/exercises/layout_demo.dart';
import 'package:login/main.dart';

void main() {
  testWidgets('Lab 4 app main menu smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const Lab4App());
    await tester.pumpAndSettle();

    expect(find.text('Lab 4 – Flutter UI Fundament...'), findsOneWidget);
    expect(find.text('Exercise 1 – Core Widgets Demo'), findsOneWidget);
    expect(find.text('Exercise 2 – Input Controls Demo'), findsOneWidget);
    expect(find.text('Exercise 3 – Layout Demo'), findsOneWidget);
    expect(find.text('Exercise 4 – App Structure & Theme'), findsOneWidget);
    expect(find.text('Exercise 5 – Common UI Fixes'), findsOneWidget);
  });

  testWidgets('Exercise 1 - Core Widgets Demo renders properly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CoreWidgetsDemo()));
    await tester.pumpAndSettle();

    expect(find.text('Exercise 1 – Core Widgets Demo'), findsOneWidget);
    expect(find.text('Welcome to Flutter UI'), findsOneWidget);
    expect(find.byIcon(Icons.movie), findsOneWidget);
    expect(find.text('Movie Item'), findsOneWidget);
    expect(
        find.text('This is a sample ListTile inside a Card.'), findsOneWidget);
  });

  testWidgets('Exercise 2 - Input Controls Demo interactive controls test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: InputControlsDemo()));
    await tester.pumpAndSettle();

    expect(find.text('Exercise 2 – Input Controls Demo'), findsOneWidget);
    expect(find.text('Rating (Slider)'), findsOneWidget);
    expect(find.text('Current value: 50'), findsOneWidget);
    expect(find.text('Active (Switch)'), findsOneWidget);
    expect(find.text('Genre (RadioListTile)'), findsOneWidget);
    expect(find.text('Open Date Picker'), findsOneWidget);

    // Toggle switch
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    // Tap radio button
    await tester.tap(find.text('Action'));
    await tester.pumpAndSettle();
    expect(find.text('Selected genre: Action'), findsOneWidget);
  });

  testWidgets('Exercise 3 - Layout Demo displays list of movies',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LayoutDemo()));
    await tester.pumpAndSettle();

    expect(find.text('Exercise 3 – Layout Demo'), findsOneWidget);
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Avatar'), findsOneWidget);
    expect(find.text('Inception'), findsOneWidget);
    expect(find.text('Interstellar'), findsOneWidget);
    expect(find.text('Joker'), findsOneWidget);
  });

  testWidgets('Exercise 4 - App Structure and Theme toggle test',
      (WidgetTester tester) async {
    final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

    await tester.pumpWidget(
      ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, mode, _) {
          return MaterialApp(
            themeMode: mode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: AppStructureThemeDemo(themeModeNotifier: themeNotifier),
          );
        },
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Exercise 4 – App Structure & Theme'), findsOneWidget);
    expect(find.text('Light Mode Active'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // Tap FAB to increment counter
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);

    // Toggle dark mode
    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pumpAndSettle();
    expect(find.text('Dark Mode Active'), findsOneWidget);
  });

  testWidgets('Exercise 5 - Common UI Fixes tabs test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CommonUiFixesDemo()));
    await tester.pumpAndSettle();

    expect(find.text('Exercise 5 – Common UI Fixes'), findsOneWidget);
    expect(find.text('Fix 1: ListView inside Column'), findsOneWidget);

    // Tap Tab 2
    await tester.tap(find.text('2. Screen Overflow'));
    await tester.pumpAndSettle();
    expect(find.text('Fix 2: Screen Overflow with SingleChildScrollView'),
        findsOneWidget);

    // Tap Tab 3
    await tester.tap(find.text('3. State Update'));
    await tester.pumpAndSettle();
    expect(find.text('Fix 3: State Update with setState()'), findsOneWidget);

    // Test setState fix
    expect(find.text('Counter value displayed: 0'), findsNWidgets(2));
    await tester.ensureVisible(find.text('Tap me (with setState)'));
    await tester.tap(find.text('Tap me (with setState)'));
    await tester.pumpAndSettle();
    expect(find.text('Counter value displayed: 1'), findsOneWidget);

    // Tap Tab 4
    await tester.tap(find.text('4. DatePicker Context'));
    await tester.pumpAndSettle();
    expect(find.text('Fix 4: DatePicker BuildContext Hierarchy'),
        findsOneWidget);
  });
}
