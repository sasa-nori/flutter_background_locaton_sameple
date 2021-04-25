import 'package:background_sample/domain/record.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'data_store.dart';

/// Singleton
class DataRepository {
  static final DataRepository _instance = new DataRepository._internal();

  factory DataRepository() {
    return _instance;
  }

  DataRepository._internal();

  final dataStore = DataStore();

  Future<List<Record>> getRecordList() async {
    List<Record> resultList = [];
    List<Location> list = await dataStore.allRecord;
    list.forEach((element) {
      resultList
          .add(Record(element.latitude, element.longitude, element.createdAt));
    });
    return resultList;
  }

  Future<void> addRecord() async {
    // 常に位置情報ONじゃないとreturn
    if (await Permission.locationAlways.isDenied) return;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    dataStore.insert(
        position.latitude.toString(), position.longitude.toString());
  }

  Future<void> deleteAll() async {
    dataStore.deleteAll();
  }
}
