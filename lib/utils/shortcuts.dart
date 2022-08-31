import 'package:flutter/material.dart';
import 'package:flutter_shortcuts/flutter_shortcuts.dart';
import 'package:self_utils/utils/toast_utils.dart';
import 'package:self_utils/widget/navigator_helper.dart';

//单例
class ShortCutsInit {
  static ShortCutsInit? _init;

  static final FlutterShortcuts _flutterShortcuts = FlutterShortcuts();

  factory ShortCutsInit() => _init ?? ShortCutsInit._this();

  ShortCutsInit._this() {
    _flutterShortcuts.initialize(debug: true);
    _flutterShortcuts.listenAction((String key) {
      _getShortcuts(key);
    });
    _init = this;
    _setShortcuts();
  }

  //处理shortcuts
  static void _getShortcuts(String key) async {
    ToastUtils.showToast(msg: '正在前往$key...');
    await Future<void>.delayed(const Duration(seconds: 2));
    switch (key) {
      case 'charts':
        final NavigatorState navigatorHelper =
            await NavigatorHelper.navigatorState;
        // navigatorHelper.push(
        //   MaterialPageRoute<void>(
        //       builder: (BuildContext context) => ListGroupPage()),
        // );
      break;
    }
  }

  //设置shortcuts
  static void _setShortcuts() {
    _flutterShortcuts.setShortcutItems(shortcutItems: <ShortcutItem>[
      const ShortcutItem(
        id: '1',
        action: 'charts',
        shortLabel: 'charts',
        icon: 'images/sun.jpg',
      ),
    ]);
  }
}