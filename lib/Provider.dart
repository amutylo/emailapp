import 'package:emailapp/ContactManager.dart';
import 'package:flutter/material.dart';

class Provider<T> extends InheritedWidget {

  final T data;

  Provider({Key key, Widget child, this.data}) : super(key:key, child:child);

  static ContactManager of<T>(BuildContext context) {
    final type = _typeOf<Provider<T>>();
    var dependOnInheritedWidgetOfExactType = context.dependOnInheritedWidgetOfExactType<Provider>(aspect: {type});
    return dependOnInheritedWidgetOfExactType.data;
  }

  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
