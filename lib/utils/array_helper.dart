import 'package:flutter/material.dart';

//数组有关的方法
class ArrayHelper {
  static T? get<T>(List<T>? list, int index) {
    if (list != null && list.isNotEmpty == true) {
      return list[index];
    } else {
      return null;
    }
  }

  static List<int> uniqueInt(List<int> list) {
    return unique<int>(listData: list, getKey: (int item) => item);
  }

  //去重_泛型
  static List<T> unique<T>(
      {required List<T> listData, required dynamic Function(T value) getKey}) {
    if (listData.isNotEmpty == true) {
      final Map<dynamic, List<T>> maps = {
        for (var e in listData)
          getKey(e): listData
              .where((T element) => getKey(element) == getKey(e))
              .toList()
      };
      final List<T> list = maps.values.map((List<T> e) => e.first).toList();
      return list..removeWhere((T? element) => element == null);
    } else {
      return <T>[];
    }
  }
}
