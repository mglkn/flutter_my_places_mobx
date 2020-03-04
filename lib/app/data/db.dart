import 'package:moor_flutter/moor_flutter.dart';

part 'db.g.dart';

class Places extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get address => text().nullable()();
  TextColumn get coordinates => text().nullable()();
  TextColumn get image => text().nullable()();
  IntColumn get rate => integer().nullable().withDefault(Constant(0))();
  DateTimeColumn get date => dateTime().nullable()();
}

@UseDao(tables: [Places])
class PlacesDao extends DatabaseAccessor<AppDatabase> {
  PlacesDao(AppDatabase db) : super(db);

  Stream<List<Place>> watchAll() => (select(db.places)).watch();

  Future<int> create(Place place) => into(db.places).insert(
        place.copyWith(
          date: DateTime.now(),
        ),
      );

  Future<bool> modify(Place place) => update(db.places).replace(place);

  Future<int> remove(Place place) => (delete(db.places)
        ..where(
          (tbl) => tbl.id.equals(place.id),
        ))
      .go();
}

@UseMoor(tables: [Places], daos: [PlacesDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  @override
  int get schemaVersion => 1;
}
