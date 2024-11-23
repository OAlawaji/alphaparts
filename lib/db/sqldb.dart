import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDB {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initializeDB();
    }
    return _db;
  }

  Future<Database> _initializeDB() async {
    
    String path = join(await getDatabasesPath(), "alphapb.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pieces (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT NOT NULL,
      name TEXT NOT NULL,
      price REAL NOT NULL
      )
    ''');
  }

  Future<int> insertPiece(String type, String name, double price) async {
    Database? mydb = await db;
    int response = await mydb!.insert('pieces', {
      'type': type,
      'name': name,
      'price': price,
    });
    // partTypes.remove(type);
    
    return response;
  }
  Future<List<Map>> readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

Future<int> deleteData(String sql, List<dynamic> list) async {
  Database? mydb = await db;
  int response = await mydb!.rawDelete(sql, list);
  return response;
}
}