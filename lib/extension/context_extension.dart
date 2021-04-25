import 'package:background_sample/view/abstract_base_view.dart';
import 'package:background_sample/view/custom/lifecycle_manager.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double getWidth() {
    return MediaQuery.of(this).size.width;
  }

  double getHeight() {
    return MediaQuery.of(this).size.height;
  }

  Future<T?> pushAndRemoveUntilWithLifecycle<T extends Object>(BaseView widget,
      {bool routeSetting = false}) {
    return Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (context) => LifecycleManager(widget)),
        (route) => routeSetting);
  }

  Future<T?> pushWithLifecycle<T extends Object>(BaseView widget) {
    return Navigator.push(this,
        MaterialPageRoute(builder: (context) => LifecycleManager(widget)));
  }

  Future<T?> pushReplacementWithLifecycle<T extends Object>(BaseView widget) {
    return Navigator.pushReplacement(this,
        MaterialPageRoute(builder: (context) => LifecycleManager(widget)));
  }
}
