import 'package:background_sample/view/custom/lifecycle_manager.dart';
import 'package:flutter/widgets.dart';

/// 基本的にStatelessWidgetで組んでてStateほしいときにはoverrideして利用可能 最初のみ何か実行したいときとか
/// これを継承させないとresumeでのトークン更新が実行されないので注意
abstract class BaseView extends StatelessWidget with LifecycleCallback {
  @override
  void onInit() {}

  @override
  void onResumed() {}

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}
}
