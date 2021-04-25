import 'dart:io';

import 'package:background_sample/domain/data_repository.dart';
import 'package:flutter/services.dart';

/// Singleton
class ChannelManger {
  static final ChannelManger _instance = new ChannelManger._internal();

  factory ChannelManger() {
    return _instance;
  }

  ChannelManger._internal();

  static const _channel =
      MethodChannel('com.example.background_sample/background_service');
  static const _startMethodName = "startBackgroundService";
  static const _cancelMethodName = "cancelBackgroundService";
  static const _targetMethodName = "locationFetch";
  static const _checkPermissionsMethodName = "checkPermissions";

  void register() {
    _channel.setMethodCallHandler(_platformCallHandler);
    checkPermissions();
    _channel.invokeMethod(_cancelMethodName);
  }

  void checkPermissions() {
    if (Platform.isAndroid) {
      _channel.invokeMethod(_checkPermissionsMethodName);
    }
  }

  /// 15分待ちたくない時のテスト用
  void requestLocation() {
    _channel.invokeMethod("requestLocation", {"methodName": "requestLocation"});
  }

  void startBackgroundService() {
    _channel.invokeMethod(
        _startMethodName, {"methodName": _targetMethodName, "minutes": 15});
  }

  void cancelBackgroundService() {
    _channel.invokeMethod(_cancelMethodName);
  }

  Future<void> _platformCallHandler(MethodCall call) async {
    switch (call.method) {
      // 15分待ちたくない時のテスト用
      case "requestLocation":
        DataRepository().addRecord();
        break;
      case _targetMethodName:
        DataRepository().addRecord();
        break;
      default:
        print('Unknown method ${call.method}');
        throw MissingPluginException();
    }
  }
}
