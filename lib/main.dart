import 'package:flutter/material.dart';
import 'widgets/input_pad.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input Pad Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const InputPadDemo(),
    );
  }
}

class InputPadDemo extends StatefulWidget {
  const InputPadDemo({super.key});

  @override
  State<InputPadDemo> createState() => _InputPadDemoState();
}

class _InputPadDemoState extends State<InputPadDemo> {
  String _inputText = '';
  List<String> _currentCharacters = InputPadPresets.hanziOnset;
  String _currentPreset = 'Hanzi Onset';

  final Map<String, List<String>> _presets = {
    'Alphabet': InputPadPresets.alphabet,
    'Hanzi Onset': InputPadPresets.hanziOnset,
  };

  void _onCharacterTap(String character) {
    setState(() {
      if (character == 'C') {
        // Clear last character
        if (_inputText.isNotEmpty) {
          _inputText = _inputText.substring(0, _inputText.length - 1);
        }
      } else if (character == 'AC') {
        // Clear all
        _inputText = '';
      } else {
        // Add character
        _inputText += character;
      }
    });
  }

  void _changePreset(String preset) {
    setState(() {
      _currentPreset = preset;
      _currentCharacters = _presets[preset] ?? InputPadPresets.hanziOnset;
    });
  }

  void _loadCustomCharacters() {
    // Dialog for entering custom character string
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String customInput = '';
        return AlertDialog(
          title: const Text('Custom Character Set'),
          content: TextField(
            onChanged: (value) => customInput = value,
            decoration: const InputDecoration(
              hintText: 'Enter characters separated by comma (,) within 35 characters',
              border: OutlineInputBorder(),
            ),
            maxLength: 35,
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _currentCharacters = customInput.split(',');
                  _currentPreset = 'Custom';
                });
                Navigator.of(context).pop();
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Input Pad Demo'),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input display area
            Container(
              height: 80,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _inputText.isEmpty ? 'Input characters will be displayed here' : _inputText,
                    style: TextStyle(
                      fontSize: 18,
                      color: _inputText.isEmpty ? Colors.grey : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Preset selection buttons
            Row(
              children: [
                const Text('Preset: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _presets.keys.map((preset) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            onPressed: () => _changePreset(preset),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _currentPreset == preset 
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                              foregroundColor: _currentPreset == preset 
                                  ? Colors.white 
                                  : null,
                            ),
                            child: Text(preset),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _loadCustomCharacters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Custom'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Input pad
            Expanded(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputPad(
                    characters: _currentCharacters,
                    onCharacterTap: _onCharacterTap,
                    buttonColor: Colors.blue.shade50,
                    textColor: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Control buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onCharacterTap('C'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Delete One'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onCharacterTap('AC'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Clear All'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
