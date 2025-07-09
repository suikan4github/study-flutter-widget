import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_flutter_widget/widgets/input_pad.dart';

void main() {
  group('InputPad Widget Tests', () {
    
    testWidgets('InputPad renders and displays characters', (WidgetTester tester) async {
      const testCharacters = ['A', 'B', 'C', 'D', 'E'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 600,
              width: 400,
              child: InputPad(
                characters: testCharacters,
                onCharacterTap: (character) {},
              ),
            ),
          ),
        ),
      );

      // Verify that GridView exists
      expect(find.byType(GridView), findsOneWidget);
      
      // Verify that specified characters are displayed
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
      
      // Verify that buttons exist
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('InputPad handles character tap correctly', (WidgetTester tester) async {
      const testCharacters = ['X', 'Y', 'Z'];
      String tappedCharacter = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 600,
              width: 400,
              child: InputPad(
                characters: testCharacters,
                onCharacterTap: (character) {
                  tappedCharacter = character;
                },
              ),
            ),
          ),
        ),
      );

      // Tap 'X' button
      await tester.tap(find.text('X'));
      await tester.pump();

      // Verify that callback was called correctly
      expect(tappedCharacter, equals('X'));

      // Tap 'Y' button
      await tester.tap(find.text('Y'));
      await tester.pump();

      expect(tappedCharacter, equals('Y'));
    });

    testWidgets('InputPad applies custom styling correctly', (WidgetTester tester) async {
      const testCharacters = ['T'];
      const customTextColor = Colors.white;
      const customFontSize = 24.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 600,
              width: 400,
              child: InputPad(
                characters: testCharacters,
                onCharacterTap: (character) {},
                buttonColor: Colors.red,
                textColor: customTextColor,
                fontSize: customFontSize,
              ),
            ),
          ),
        ),
      );

      // Verify that custom text style is applied
      final textWidget = tester.widget<Text>(find.text('T'));
      expect(textWidget.style?.color, equals(customTextColor));
      expect(textWidget.style?.fontSize, equals(customFontSize));
    });

    testWidgets('InputPad grid layout is configured correctly', (WidgetTester tester) async {
      const testCharacters = ['1', '2', '3', '4', '5', '6'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 600,
              width: 400,
              child: InputPad(
                characters: testCharacters,
                onCharacterTap: (character) {},
              ),
            ),
          ),
        ),
      );

      // Verify that GridView is configured correctly
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate = gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      
      expect(delegate.crossAxisCount, equals(5));
      expect(delegate.crossAxisSpacing, equals(4.0));
      expect(delegate.mainAxisSpacing, equals(4.0));
      expect(delegate.childAspectRatio, equals(1.0));
    });
  });

  group('InputPadPresets Tests', () {
    test('Alphabet preset has correct characters', () {
      expect(InputPadPresets.alphabet.length, greaterThanOrEqualTo(26));
      expect(InputPadPresets.alphabet, contains('A'));
      expect(InputPadPresets.alphabet, contains('Z'));
      expect(InputPadPresets.alphabet, contains('!'));
      expect(InputPadPresets.alphabet, contains('?'));
    });

    test('Alphabet preset fits within 35 characters limit', () {
      expect(InputPadPresets.alphabet.length, lessThanOrEqualTo(35));
    });
  });
}
