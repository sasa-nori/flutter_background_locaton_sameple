import 'dart:ui';

import 'package:background_sample/domain/record.dart';
import 'package:background_sample/extension/context_extension.dart';
import 'package:background_sample/view/abstract_base_view.dart';
import 'package:background_sample/view/custom/single_scrollbar_view.dart';
import 'package:background_sample/view_model/record_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class RecordListView extends BaseView {
  @override
  Widget build(BuildContext context) {
    final viewModel = RecordListViewModel();
    return Scaffold(
        appBar: AppBar(
          title: Text("レコードリスト", style: TextStyle(fontWeight: FontWeight.bold)),
          elevation: 0,
          centerTitle: false,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.close),
          onPressed: () {
            viewModel.clearData();
          },
        ),
        body: ChangeNotifierProvider(
            create: (context) => viewModel,
            child: SingleScrollbarView(
              child: Container(
                  width: context.getWidth(),
                  height: context.getHeight(),
                  child: Consumer<RecordListViewModel>(
                      builder: (context, viewModel, _) {
                    _listen(context, viewModel);
                    return _buildContent(context, viewModel);
                  })),
            )));
  }

  void _listen(BuildContext context, RecordListViewModel viewModel) {
    switch (viewModel.state) {
      case RecordListViewModelState.PERMISSION_GRANTED:
        if (viewModel.recordList.isNotEmpty) return;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                    title: Text("データなし"),
                    content: Text("アプリを閉じて15分以上お待ち下さい"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          SystemNavigator.pop(animated: true);
                        },
                        child: Text("OK"),
                      ),
                    ]);
              });
        });
        break;
      case RecordListViewModelState.SHOW_SETTING:
        _showSetting(viewModel);
        break;
      case RecordListViewModelState.PERMISSION_DENIED:
        viewModel.fetch();
        break;
      default:
        break;
    }
  }

  void _showSetting(RecordListViewModel viewModel) async {
    await openAppSettings();
    // 設定画面から戻ってきたらリトライ
    viewModel.fetch();
  }

  Widget _buildContent(BuildContext context, RecordListViewModel viewModel) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return createCell(viewModel.recordList[index]);
        },
        itemCount: viewModel.recordList.length);
  }

  Widget createCell(Record record) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: const Border(
            bottom: const BorderSide(color: Colors.grey, width: 3),
          ),
        ),
        child: Column(children: [
          Row(children: [
            Text("日付 : "),
            Flexible(child: Text(record.createdAt))
          ]),
          Row(children: [
            Text("緯度 : "),
            Flexible(child: Text(record.longitude))
          ]),
          Row(children: [
            Text("経度 : "),
            Flexible(child: Text(record.latitude))
          ]),
        ]));
  }
}
