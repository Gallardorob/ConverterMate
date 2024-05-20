import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unit_converter_app/models/favorites.dart';

class FavDatabase {
  static final FavDatabase instance = FavDatabase._init();

  static Database _database;
  FavDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('favs.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes(
  ${FavoritesFields.id} $idType,
  ${FavoritesFields.title} $textType,
  ${FavoritesFields.navPos} $textType,
  ${FavoritesFields.fromPos} $textType,
  ${FavoritesFields.toPos} $textType
)
''');
  }

  Future<Favorites> create(Favorites note) async {
    final db = await instance.database;
    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Favorites> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: FavoritesFields.values,
      where: '${FavoritesFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Favorites.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Favorites>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${FavoritesFields.id} ASC';
    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Favorites.fromJson(json)).toList();
  }

  Future<int> update(Favorites fav) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      fav.toJson(),
      where: '${FavoritesFields.id} = ?',
      whereArgs: [fav.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${FavoritesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
