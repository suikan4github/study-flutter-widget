import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_flutter_widget/widgets/input_pad.dart';

void main() {
  group('InputPad Widget Tests', () {
    
    testWidgets('InputPad renders and displays characters', (WidgetTester tester) async {
      const testCharacters = [
        ['a1', 'b1', 'c1', 'd1', 'e1'],
        ['a2', 'b2', 'c2', 'd2', 'e2'],
        ['a3', 'b3', 'c3', 'd3', 'e3'],
        ['a4', 'b4', 'c4', 'd4', 'e4'],
        ['a5', 'b5', 'c5', 'd5', 'e5'],
        ['a6', 'b6', 'c6', 'd6', 'e6'],
        ['a7', 'b7', 'c7', 'd7', 'e7'],
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 600,
              width: 400,
              child: InputPad(
                characters: testCharacters,
                buttonEnabled: InputPadPresets.allEnabledMask,
                onCharacterTap: (character) {},
              ),
            ),
          ),
        ),
      );

      // Verify that GridView exists
      expect(find.byType(GridView), findsOneWidget);
      
      // Verify that specified characters are displayed
      expect(find.text('b3'), findsOneWidget);
      expect(find.text('c4'), findsOneWidget);
      expect(find.text('d5'), findsOneWidget);
      
      // Verify that buttons exist
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('InputPad handles character tap correctly', (WidgetTester tester) async {
      const testCharacters = [
        ['a1', 'b1', 'c1', 'd1', 'e1'],
        ['a2', 'b2', 'c2', 'd2', 'e2'],
        ['a3', 'b3', 'c3', 'd3', 'e3'],
        ['a4', 'b4', 'c4', 'd4', 'e4'],
        ['a5', 'b5', 'c5', 'd5', 'e5'],
        ['a6', 'b6', 'c6', 'd6', 'e6'],
        ['a7', 'b7', 'c7', 'd7', 'e7'],
      ];
      String tappedCharacter = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 600,
              width: 400,
              child: InputPad(
                characters: testCharacters,
                buttonEnabled: InputPadPresets.allEnabledMask,
                onCharacterTap: (character) {
                  tappedCharacter = character;
                },
              ),
            ),
          ),
        ),
      );

      // Tap 'd3' button
      await tester.tap(find.text('d3'));
      await tester.pump();

      // Verify that callback was called correctly
      expect(tappedCharacter, equals('d3'));

      // Tap 'e4' button
      await tester.tap(find.text('e4'));
      await tester.pump();

      expect(tappedCharacter, equals('e4'));
    });

    testWidgets('InputPad applies custom styling correctly', (WidgetTester tester) async {
      const testCharacters = [
        ['a1', 'b1', 'c1', 'd1', 'e1'],
        ['a2', 'b2', 'c2', 'd2', 'e2'],
        ['a3', 'b3', 'c3', 'd3', 'e3'],
        ['a4', 'b4', 'c4', 'd4', 'e4'],
        ['a5', 'b5', 'c5', 'd5', 'e5'],
        ['a6', 'b6', 'c6', 'd6', 'e6'],
        ['a7', 'b7', 'c7', 'd7', 'e7'],
      ];
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
                buttonEnabled: InputPadPresets.allEnabledMask,
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
      final textWidget = tester.widget<Text>(find.text('b6'));
      expect(textWidget.style?.color, equals(customTextColor));
      expect(textWidget.style?.fontSize, equals(customFontSize));
    });

    testWidgets('InputPad grid layout is configured correctly', (WidgetTester tester) async {
      const testCharacters = [
        ['a1', 'b1', 'c1', 'd1', 'e1'],
        ['a2', 'b2', 'c2', 'd2', 'e2'],
        ['a3', 'b3', 'c3', 'd3', 'e3'],
        ['a4', 'b4', 'c4', 'd4', 'e4'],
        ['a5', 'b5', 'c5', 'd5', 'e5'],
        ['a6', 'b6', 'c6', 'd6', 'e6'],
        ['a7', 'b7', 'c7', 'd7', 'e7'],
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 600,
              width: 400,
              child: InputPad(
                characters: testCharacters,
                buttonEnabled: InputPadPresets.allEnabledMask,
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
      expect(delegate.childAspectRatio, equals(2.0));
    });
  });

  group('InputPadPresets Tests', () {
    test('Alphabet preset has correct characters', () {
      expect(
        InputPadPresets.alphabet.length * InputPadPresets.alphabet[0].length,
        35,
      );
      expect(InputPadPresets.alphabet[0], contains('a'));
      expect(InputPadPresets.alphabet[1], contains('j'));
      expect(InputPadPresets.alphabet[5], contains('z'));
      expect(InputPadPresets.alphabet[6], contains('I'));
    });

    test('Alphabet preset fits within 35 characters limit', () {
      expect(InputPadPresets.alphabet.length, lessThanOrEqualTo(35));
    });
  });
}
