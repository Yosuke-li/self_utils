import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

ScreenUtil screenUtil = ScreenUtil._instance;

class ScreenWidget extends StatefulWidget {
  Widget child;

  ScreenWidget({Key? key, required this.child}) : super(key: key);

  @override
  _ScreenWidgetState createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    if (ScreenUtil.checkNeedUpdate()) {
      setState(() {});
    }
  }

  @override
  void didChangeTextScaleFactor() {
    if (ScreenUtil.checkNeedUpdate()) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return widget.child;
  }
}


class ScreenUtil {
  static ScreenUtil _instance = ScreenUtil._();
  static int width = 1000; //设计稿宽度
  static int height = 2111; //设计稿高度
  static late double _deviceWidth; //实际设备宽度
  static late double _deviceHeight; //实际设备高度
  static late double _textScaleFactor; //字体的缩放比例

  ScreenUtil._();


  static bool checkNeedUpdate() {
    MediaQueryData newMediaQuery = MediaQueryData.fromWindow(window);
    return
      newMediaQuery.size.width != _deviceWidth ||
          newMediaQuery.size.height != _deviceHeight ||
          newMediaQuery.textScaleFactor != _textScaleFactor;
  }


  static void init() {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    _deviceWidth = min(mediaQuery.size.width, mediaQuery.size.height);
    _deviceHeight = max(mediaQuery.size.width, mediaQuery.size.height);
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  //实际的dp与设计稿px的比例
  static double get scaleWidth => _deviceWidth / width;

  static double get scaleHeight => _deviceHeight / height;

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  double adaptive(double px) => px * scaleWidth;

  // 根据设计稿的设备高度适配
  double getHeight(double px) => px * scaleHeight;

  //字体大小适配方法
  ///@param fontSize 设计稿上字体的px ,
  ///@param needSysFontScale 字体是否要根据系统的字体大小来进行缩放。默认值为true。
  double getAutoSp(double px) => adaptive(px) / _textScaleFactor;

}