// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_store.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Location extends DataClass implements Insertable<Location> {
  final int id;
  final String longitude;
  final String latitude;
  final String createdAt;

  Location(
      {required this.id,
      required this.longitude,
      required this.latitude,
      required this.createdAt});

  factory Location.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Location(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      longitude: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude']),
      latitude: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude']),
      createdAt: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<String>(longitude);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<String>(latitude);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    return map;
  }

  TableLocationCompanion toCompanion(bool nullToAbsent) {
    return TableLocationCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory Location.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<int>(json['id']),
      longitude: serializer.fromJson<String>(json['longitude']),
      latitude: serializer.fromJson<String>(json['latitude']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'longitude': serializer.toJson<String>(longitude),
      'latitude': serializer.toJson<String>(latitude),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Location copyWith(
          {int? id, String? longitude, String? latitude, String? createdAt}) =>
      Location(
        id: id ?? this.id,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(longitude.hashCode, $mrjc(latitude.hashCode, createdAt.hashCode))));

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.longitude == this.longitude &&
          other.latitude == this.latitude &&
          other.createdAt == this.createdAt);
}

class TableLocationCompanion extends UpdateCompanion<Location> {
  final Value<int> id;
  final Value<String> longitude;
  final Value<String> latitude;
  final Value<String> createdAt;

  const TableLocationCompanion({
    this.id = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
    this.createdAt = const Value.absent(),
  });

  TableLocationCompanion.insert({
    this.id = const Value.absent(),
    required String longitude,
    required String latitude,
    required String createdAt,
  })   : longitude = Value(longitude),
        latitude = Value(latitude),
        createdAt = Value(createdAt);

  static Insertable<Location> custom({
    Expression<int>? id,
    Expression<String>? longitude,
    Expression<String>? latitude,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TableLocationCompanion copyWith(
      {Value<int>? id,
      Value<String>? longitude,
      Value<String>? latitude,
      Value<String>? createdAt}) {
    return TableLocationCompanion(
      id: id ?? this.id,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<String>(longitude.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<String>(latitude.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TableLocationCompanion(')
          ..write('id: $id, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TableLocationTable extends TableLocation
    with TableInfo<$TableLocationTable, Location> {
  final GeneratedDatabase _db;
  final String? _alias;

  $TableLocationTable(this._db, [this._alias]);

  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();

  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  @override
  late final GeneratedTextColumn longitude = _constructLongitude();

  GeneratedTextColumn _constructLongitude() {
    return GeneratedTextColumn(
      'longitude',
      $tableName,
      false,
    );
  }

  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  @override
  late final GeneratedTextColumn latitude = _constructLatitude();

  GeneratedTextColumn _constructLatitude() {
    return GeneratedTextColumn(
      'latitude',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedTextColumn createdAt = _constructCreatedAt();

  GeneratedTextColumn _constructCreatedAt() {
    return GeneratedTextColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, longitude, latitude, createdAt];

  @override
  $TableLocationTable get asDslTable => this;

  @override
  String get $tableName => _alias ?? 'table_location';
  @override
  final String actualTableName = 'table_location';

  @override
  VerificationContext validateIntegrity(Insertable<Location> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude'], _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude'], _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Location.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TableLocationTable createAlias(String alias) {
    return $TableLocationTable(_db, alias);
  }
}

abstract class _$DataStore extends GeneratedDatabase {
  _$DataStore(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TableLocationTable tableLocation = $TableLocationTable(this);

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tableLocation];
}
