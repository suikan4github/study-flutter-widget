import 'package:flutter/material.dart';

class InputPad extends StatefulWidget {
  final List<List<String>> _characters;
  final List<List<bool>> _buttonEnabled;
  final Function(String) _onCharacterTap;
  final Color? _buttonColor;
  final Color? _textColor;
  final double? _buttonSize;
  final double? _fontSize;

  const InputPad({
    super.key,
    required List<List<String>> characters,
    required List<List<bool>> buttonEnabled,
    required dynamic Function(String) onCharacterTap,
    Color? buttonColor,
    Color? textColor,
    double? buttonSize,
    double? fontSize,
  }) : _onCharacterTap = onCharacterTap,
       _fontSize = fontSize,
       _buttonSize = buttonSize,
       _textColor = textColor,
       _buttonColor = buttonColor,
       _characters = characters,
       _buttonEnabled = buttonEnabled;

  @override
  State<InputPad> createState() => _InputPadState();
}

class _InputPadState extends State<InputPad> {
  static const int rows = 7;
  static const int columns = 5;
  static const int totalButtons = rows * columns;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: columns,
        crossAxisSpacing: 4.0, // Horizontal space.
        mainAxisSpacing: 4.0, // Vertical space.
        childAspectRatio: 2.0, // = Horizontal / Vertical.
        // All items are listed here.
        children: List.generate(totalButtons, (index) {
          return _buildButton(index);
        }),
      ),
    );
  }

  Widget _buildButton(int index) {
    // Display character if index exists in character array, otherwise empty string
    final character = index < columns * rows
        ? widget._characters[index ~/ columns][index % columns]
        : '';

    // Check if the button is enabled
    final isEnabled = index < columns * rows
        ? widget._buttonEnabled[index ~/ columns][index % columns]
        : false;

    return Material(
      color: widget._buttonColor ?? Colors.blue.shade100,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: character.isNotEmpty && isEnabled
            ? () => widget._onCharacterTap(character)
            : null,
        child: Container(
          width: widget._buttonSize ?? 60.0,
          height: widget._buttonSize ?? 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
          ),
          child: Center(
            child: Text(
              character,
              style: TextStyle(
                fontSize: widget._fontSize ?? 18.0,
                fontWeight: FontWeight.w500,
                color: isEnabled
                    ? widget._textColor ?? Colors.black
                    : Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Utility class for preset character sets
class InputPadPresets {
  // Alphabet
  static const List<List<String>> alphabet = [
    ['a', 'b', 'c', 'd', 'e'],
    ['f', 'g', 'h', 'i', 'j'],
    ['k', 'l', 'm', 'n', 'o'],
    ['p', 'q', 'r', 's', 't'],
    ['u', 'v', 'w', 'x', 'y'],
    ['z', 'A', 'B', 'C', 'D'],
    ['E', 'F', 'G', 'H', 'I'],
  ];
  // Hanzi onset (Chinese initials)
  static const List<List<String>> hanziOnset = [
    ['b', 'd', '', '', 'g'],
    ['p', 't', '', '', 'k'],
    ['m', 'n', '', '', ''],
    ['', 'z', 'zh', 'j', ''],
    ['', 'c', 'ch', 'q', ''],
    ['f', 's', 'sh', 'x', 'h'],
    ['', 'l', 'r', '', ''],
  ];

  // Mask for all enabled buttons.
  static const List<List<bool>> allEnabledMask = [
    [true, true, true, true, true],
    [true, true, true, true, true],
    [true, true, true, true, true],
    [true, true, true, true, true],
    [true, true, true, true, true],
    [true, true, true, true, true],
    [true, true, true, true, true],
  ];

  // Mask for Hanzi onset.
  static const List<List<bool>> defaultHanziMask = [
    [true, true, false, false, true],
    [true, true, false, false, true],
    [true, true, false, false, false],
    [false, true, true, true, false],
    [false, true, true, true, false],
    [true, true, true, true, true],
    [false, true, true, false, false],
  ];
}
