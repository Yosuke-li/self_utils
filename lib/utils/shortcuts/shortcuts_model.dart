import 'package:flutter_shortcuts/flutter_shortcuts.dart';

typedef ShortCutsFunc = void Function();

class ShortCutsModel {
  ShortcutItem shortcutItem;
  ShortCutsFunc callBackFunc;

  ShortCutsModel({required this.shortcutItem, required this.callBackFunc});
}
