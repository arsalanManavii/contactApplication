import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  String _databaseName = 'contactDB.db';
  int _version = 1;

  static const table = 'contact';
  static const columnId = '_id';
  static const columnName = 'contactName';
  static const columnNumber = 'contactNumber';
  static const columnIsLiked = 'isLiked';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

   Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _version,
      onCreate: (db, version)async {
        await db.execute(
            'CREATE table $table($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT NOT NULL, $columnNumber TEXT NOT NULL, $columnIsLiked INTEGER NOT NULL)');
      },
    );
  }
}
