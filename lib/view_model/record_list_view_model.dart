import 'dart:io';

import 'package:background_sample/domain/data_repository.dart';
import 'package:background_sample/domain/record.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordListViewModel extends ChangeNotifier {
  RecordListViewModel() {
    recordList = [];
    state = RecordListViewModelState.NONE;
    fetch();
  }

  final DataRepository _dataRepository = DataRepository();

  late List<Record> recordList;

  late RecordListViewModelState state;

  void fetch() async {
    [
      Permission.location,
      Permission.locationWhenInUse,
      Permission.locationAlways
    ].request().then((value) {
      var isDenied = false;
      value.forEach((key, value) {
        if (value.isDenied) {
          isDenied = true;
        }
      });
      if (isDenied) {
        if (Platform.isAndroid) {
          state = RecordListViewModelState.SHOW_SETTING;
        } else {
          state = RecordListViewModelState.PERMISSION_DENIED;
        }
        notifyListeners();
      } else {
        state = RecordListViewModelState.PERMISSION_GRANTED;

        _dataRepository.getRecordList().then((value) {
          recordList.addAll(value);
          notifyListeners();
        });
      }
    });
  }
}

enum RecordListViewModelState {
  PERMISSION_DENIED,
  PERMISSION_GRANTED,
  SHOW_SETTING,
  NONE
}
