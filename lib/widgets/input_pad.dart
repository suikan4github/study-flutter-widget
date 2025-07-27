import 'package:flutter/material.dart';

class InputPad extends StatefulWidget {
  final List<List<String>> characters;
  final Function(String) onCharacterTap;
  final Color? buttonColor;
  final Color? textColor;
  final double? buttonSize;
  final double? fontSize;

  const InputPad({
    super.key,
    required this.characters,
    required this.onCharacterTap,
    this.buttonColor,
    this.textColor,
    this.buttonSize,
    this.fontSize,
  });

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
        ? widget.characters[index ~/ columns][index % columns]
        : '';

    return Material(
      color: widget.buttonColor ?? Colors.blue.shade100,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: character.isNotEmpty
            ? () => widget.onCharacterTap(character)
            : null,
        child: Container(
          width: widget.buttonSize ?? 60.0,
          height: widget.buttonSize ?? 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
          ),
          child: Center(
            child: Text(
              character,
              style: TextStyle(
                fontSize: widget.fontSize ?? 18.0,
                fontWeight: FontWeight.w500,
                color: widget.textColor ?? Colors.black87,
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
}
