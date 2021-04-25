import 'package:background_sample/domain/table_location.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'data_store.g.dart';

/// Singleton
@UseMoor(tables: [TableLocation])
class DataStore extends _$DataStore {
  static final DataStore _instance = new DataStore._internal();

  factory DataStore() {
    return _instance;
  }

  DataStore._internal()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  void insert(String latitude, String longitude) {
    into(tableLocation).insert(TableLocationCompanion.insert(
        latitude: latitude,
        longitude: longitude,
        createdAt: DateFormat('yyyy/MM/dd/ HH:mm:ss').format(DateTime.now())));
  }

  Future<List<Location>> get allRecord => select(tableLocation).get();
}
