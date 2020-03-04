// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Place extends DataClass implements Insertable<Place> {
  final int id;
  final String name;
  final String type;
  final String address;
  final String coordinates;
  final String image;
  final int rate;
  final DateTime date;
  Place(
      {this.id,
      @required this.name,
      @required this.type,
      this.address,
      this.coordinates,
      this.image,
      this.rate,
      this.date});
  factory Place.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Place(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      address:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}address']),
      coordinates: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}coordinates']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      rate: intType.mapFromDatabaseResponse(data['${effectivePrefix}rate']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  factory Place.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Place(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      address: serializer.fromJson<String>(json['address']),
      coordinates: serializer.fromJson<String>(json['coordinates']),
      image: serializer.fromJson<String>(json['image']),
      rate: serializer.fromJson<int>(json['rate']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'address': serializer.toJson<String>(address),
      'coordinates': serializer.toJson<String>(coordinates),
      'image': serializer.toJson<String>(image),
      'rate': serializer.toJson<int>(rate),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  @override
  PlacesCompanion createCompanion(bool nullToAbsent) {
    return PlacesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      coordinates: coordinates == null && nullToAbsent
          ? const Value.absent()
          : Value(coordinates),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      rate: rate == null && nullToAbsent ? const Value.absent() : Value(rate),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  Place copyWith(
          {int id,
          String name,
          String type,
          String address,
          String coordinates,
          String image,
          int rate,
          DateTime date}) =>
      Place(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        address: address ?? this.address,
        coordinates: coordinates ?? this.coordinates,
        image: image ?? this.image,
        rate: rate ?? this.rate,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Place(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('address: $address, ')
          ..write('coordinates: $coordinates, ')
          ..write('image: $image, ')
          ..write('rate: $rate, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              type.hashCode,
              $mrjc(
                  address.hashCode,
                  $mrjc(
                      coordinates.hashCode,
                      $mrjc(image.hashCode,
                          $mrjc(rate.hashCode, date.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Place &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.address == this.address &&
          other.coordinates == this.coordinates &&
          other.image == this.image &&
          other.rate == this.rate &&
          other.date == this.date);
}

class PlacesCompanion extends UpdateCompanion<Place> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> address;
  final Value<String> coordinates;
  final Value<String> image;
  final Value<int> rate;
  final Value<DateTime> date;
  const PlacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.address = const Value.absent(),
    this.coordinates = const Value.absent(),
    this.image = const Value.absent(),
    this.rate = const Value.absent(),
    this.date = const Value.absent(),
  });
  PlacesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String type,
    this.address = const Value.absent(),
    this.coordinates = const Value.absent(),
    this.image = const Value.absent(),
    this.rate = const Value.absent(),
    this.date = const Value.absent(),
  })  : name = Value(name),
        type = Value(type);
  PlacesCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> type,
      Value<String> address,
      Value<String> coordinates,
      Value<String> image,
      Value<int> rate,
      Value<DateTime> date}) {
    return PlacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      image: image ?? this.image,
      rate: rate ?? this.rate,
      date: date ?? this.date,
    );
  }
}

class $PlacesTable extends Places with TableInfo<$PlacesTable, Place> {
  final GeneratedDatabase _db;
  final String _alias;
  $PlacesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _addressMeta = const VerificationMeta('address');
  GeneratedTextColumn _address;
  @override
  GeneratedTextColumn get address => _address ??= _constructAddress();
  GeneratedTextColumn _constructAddress() {
    return GeneratedTextColumn(
      'address',
      $tableName,
      true,
    );
  }

  final VerificationMeta _coordinatesMeta =
      const VerificationMeta('coordinates');
  GeneratedTextColumn _coordinates;
  @override
  GeneratedTextColumn get coordinates =>
      _coordinates ??= _constructCoordinates();
  GeneratedTextColumn _constructCoordinates() {
    return GeneratedTextColumn(
      'coordinates',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _rateMeta = const VerificationMeta('rate');
  GeneratedIntColumn _rate;
  @override
  GeneratedIntColumn get rate => _rate ??= _constructRate();
  GeneratedIntColumn _constructRate() {
    return GeneratedIntColumn('rate', $tableName, true,
        defaultValue: Constant(0));
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, address, coordinates, image, rate, date];
  @override
  $PlacesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'places';
  @override
  final String actualTableName = 'places';
  @override
  VerificationContext validateIntegrity(PlacesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.type.present) {
      context.handle(
          _typeMeta, type.isAcceptableValue(d.type.value, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (d.address.present) {
      context.handle(_addressMeta,
          address.isAcceptableValue(d.address.value, _addressMeta));
    }
    if (d.coordinates.present) {
      context.handle(_coordinatesMeta,
          coordinates.isAcceptableValue(d.coordinates.value, _coordinatesMeta));
    }
    if (d.image.present) {
      context.handle(
          _imageMeta, image.isAcceptableValue(d.image.value, _imageMeta));
    }
    if (d.rate.present) {
      context.handle(
          _rateMeta, rate.isAcceptableValue(d.rate.value, _rateMeta));
    }
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Place map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Place.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PlacesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.type.present) {
      map['type'] = Variable<String, StringType>(d.type.value);
    }
    if (d.address.present) {
      map['address'] = Variable<String, StringType>(d.address.value);
    }
    if (d.coordinates.present) {
      map['coordinates'] = Variable<String, StringType>(d.coordinates.value);
    }
    if (d.image.present) {
      map['image'] = Variable<String, StringType>(d.image.value);
    }
    if (d.rate.present) {
      map['rate'] = Variable<int, IntType>(d.rate.value);
    }
    if (d.date.present) {
      map['date'] = Variable<DateTime, DateTimeType>(d.date.value);
    }
    return map;
  }

  @override
  $PlacesTable createAlias(String alias) {
    return $PlacesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PlacesTable _places;
  $PlacesTable get places => _places ??= $PlacesTable(this);
  PlacesDao _placesDao;
  PlacesDao get placesDao => _placesDao ??= PlacesDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [places];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$PlacesDaoMixin on DatabaseAccessor<AppDatabase> {
  $PlacesTable get places => db.places;
}
