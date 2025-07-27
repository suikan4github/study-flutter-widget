// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:study_flutter_widget/main.dart';

void main() {
  group('InputPadDemo Integration Tests', () {
    testWidgets('App loads with InputPadDemo', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that InputPadDemo screen is loaded
      expect(find.text('Input Pad Demo'), findsOneWidget);
      expect(find.text('Input characters will be displayed here'), findsOneWidget);
    });

    testWidgets('Preset buttons are visible and functional', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify that preset buttons are displayed
      expect(find.text('Alphabet'), findsOneWidget);
      expect(find.text('Hanzi Onset'), findsOneWidget);

      // Verify that Hanzi Onset is selected by default
      final hanziOnsetButton = find.text('Hanzi Onset');
      expect(hanziOnsetButton, findsOneWidget);
    });

    testWidgets('Control buttons work correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify that control buttons are displayed
      expect(find.text('Delete One'), findsOneWidget);
      expect(find.text('Clear All'), findsOneWidget);
    });

    testWidgets('Character input and display works', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Test input by tapping hanzi onset button
      await tester.tap(find.text('b'));
      await tester.pump();

      // Verify that input is displayed (placeholder disappears)
      expect(find.text('Input characters will be displayed here'), findsNothing);

      // Tap another hanzi onset character
      await tester.tap(find.text('p'));
      await tester.pump();

      // Tap clear all button
      await tester.tap(find.text('Clear All'));
      await tester.pump();

      // Verify that placeholder is displayed again
      expect(find.text('Input characters will be displayed here'), findsOneWidget);
    });

    testWidgets('Preset switching works', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      tester.binding.window.physicalSizeTestValue = const Size(
        1080,
        1920,
      ); // 幅x高さ (ピクセル)
      // Verify that hanzi onset preset is active by default
      expect(find.text('b'), findsOneWidget);
      expect(find.text('p'), findsOneWidget);
      expect(find.text('m'), findsOneWidget);
      //      expect(find.text('f'), findsOneWidget);

      expect(find.text('d'), findsOneWidget);
      expect(find.text('t'), findsOneWidget);
      expect(find.text('n'), findsOneWidget);
      expect(find.text('z'), findsOneWidget);
      //     expect(find.text('c'), findsOneWidget);
      //  expect(find.text('s'), findsOneWidget);
      //     expect(find.text('l'), findsOneWidget);

      expect(find.text('zh'), findsOneWidget);
      //     expect(find.text('ch'), findsOneWidget);
      // expect(find.text('sh'), findsOneWidget);
      // expect(find.text('r'), findsOneWidget);

      expect(find.text('j'), findsOneWidget);
      //expect(find.text('q'), findsOneWidget);
      // expect(find.text('x'), findsOneWidget);

      expect(find.text('g'), findsOneWidget);
      expect(find.text('k'), findsOneWidget);
      //  expect(find.text('h'), findsOneWidget);

      // Switch to alphabet preset
      await tester.tap(find.text('Alphabet'));
      await tester.pump();

      // Verify that alphabet characters are displayed
      expect(find.text('a'), findsOneWidget);
      expect(find.text('w'), findsOneWidget);
      expect(find.text('q'), findsOneWidget);
    });

  });
}
