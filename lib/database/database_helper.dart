import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final database = "athendat.db";

  String product = 'CREATE TABLE products (id INTEGER PRIMARY KEY AUTOINCREMENT, title varchar NULL, description TEXT NULL, category TEXT NULL, price DOUBLE NULL, thumbnail TEXT null)';

  Future<Database> initDB () async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, database);
    
    return openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute(product);
      }
    );
  }
}
