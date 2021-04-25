import 'package:background_sample/domain/channel_manager.dart';
import 'package:background_sample/view/abstract_base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// ライフサイクルを受け取れるStatefulWidget
/// これが iOSだとAppDelegateでAndroidだとApplicationクラスの役割をしてくれる
/// が、Singletonではなく各画面のラッパーになってるだけなので排他制御とかは不可なので注意
class LifecycleManager extends StatefulWidget {
  final BaseView child;

  LifecycleManager(this.child, {Key? key}) : super(key: key);

  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifecycleManager>
    with WidgetsBindingObserver {
  final _channelManger = ChannelManger();

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    _channelManger.register();
    widget.child.onInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _channelManger.cancelBackgroundService();
        widget.child.onResumed();
        break;
      case AppLifecycleState.inactive:
        _channelManger.startBackgroundService();
        widget.child.onInactive();
        break;
      case AppLifecycleState.paused:
        widget.child.onPaused();
        break;
      case AppLifecycleState.detached:
        widget.child.onDetached();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}

/// ライフサイクルコールバックインターフェース
abstract class LifecycleCallback {
  void onInit();

  void onResumed();

  void onPaused();

  void onInactive();

  void onDetached();
}
