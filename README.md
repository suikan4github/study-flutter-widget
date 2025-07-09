# Study Flutter Widget

Flutterウィジェットの学習プロジェクトです。

## 実装したウィジェット

### InputPad - 行列状入力パッド

横5縦7の行列状入力パッドウィジェットです。

#### 主な機能

- **動的文字ロード**: 表示する文字をダイナミックに変更可能
- **プリセット文字セット**: 
  - 数字（Numbers）
  - ひらがな（Hiragana）  
  - アルファベット（Alphabet）
  - 記号（Symbols）
- **カスタム文字セット**: ユーザーが独自の文字を設定可能
- **入力機能**: タップした文字を画面上部に表示
- **編集機能**: 一文字削除、全削除

#### 使用方法

```dart
import 'widgets/input_pad.dart';

InputPad(
  characters: ['1', '2', '3', '4', '5', ...], // 表示したい文字配列
  onCharacterTap: (character) {
    // 文字がタップされた時の処理
    print('Tapped: $character');
  },
  buttonColor: Colors.blue.shade50,  // ボタンの背景色
  textColor: Colors.black87,         // 文字色
  fontSize: 16,                      // フォントサイズ
)
```

#### プリセット文字セット

```dart
// 数字パッド
InputPadPresets.numbers

// ひらがな
InputPadPresets.hiragana

// アルファベット
InputPadPresets.alphabet

// 記号
InputPadPresets.symbols
```

## 実行方法

```bash
# 依存関係のインストール
flutter pub get

# アプリの実行（デスクトップ）
flutter run -d linux

# アプリの実行（Web）
flutter run -d chrome
```

## プロジェクト構造

```
lib/
├── main.dart           # メインアプリケーション
└── widgets/
    └── input_pad.dart  # InputPadウィジェット
```
