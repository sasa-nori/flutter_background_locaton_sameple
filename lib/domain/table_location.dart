import 'package:moor/moor.dart';

@DataClassName("Location")
class TableLocation extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get longitude => text()();

  TextColumn get latitude => text()();

  TextColumn get createdAt => text()();
}
