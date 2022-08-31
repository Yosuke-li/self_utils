

import 'dart:collection';

import 'package:flutter/material.dart';

class _ListenerEntry<T> extends LinkedListEntry<_ListenerEntry<T>> {
  _ListenerEntry(this.listener);
  final T listener;
}

abstract class GenericListenable<T>  {
  final LinkedList<_ListenerEntry<T>> _list = LinkedList<_ListenerEntry<T>>();


  bool hasListener(){
    return _list.isNotEmpty;
  }

  void addListener(T listener) {
    _list.add(_ListenerEntry<T>(listener));
  }

  void removeListener(T listener) {
    for (final _ListenerEntry<T> entry in _list) {
      if (entry.listener == listener) {
        entry.unlink();
        return;
      }
    }
  }

  void foreach(void action(T entry)){
    final List<_ListenerEntry<T>> copy = List<_ListenerEntry<T>>.from(_list);
    copy.forEach((entry) {
      action(entry.listener);
    });
  }
}

