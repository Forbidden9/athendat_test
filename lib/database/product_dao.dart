import 'package:athendat_test/database/database_helper.dart';
import 'package:athendat_test/models/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductDao {
  final database = DatabaseHelper();

  Future<List<Product>> getProducts() async {
    final Database db = await database.initDB();
    final List<Map<String, dynamic>> products = await db.query("products", orderBy: "id");
    return products.map((p) => Product.fromJson(p)).toList();
  }

  Future<List<Product>> fetchProducts(int page, {int limit = 7}) async {
    final Database db = await database.initDB();
    final List<Map<String, dynamic>> products = await db.query('products', limit: limit, offset: page * limit);
    return products.map((p) => Product.fromJson(p)).toList();
  }

  Future<int> createProduct(Product p) async {
    final Database db = await database.initDB();
    final getProduct = await db.query('products', where: 'title = ?', whereArgs: [p.title!.toLowerCase()]);
    if (getProduct.isNotEmpty) {
      return 0;
    } else {
      return db.insert("products", p.toJson());
    }
  }

  Future<void> deleteProduct(int id) async{
    final Database db = await database.initDB();
    db.delete("products", where: "id = ?", whereArgs: [id]);
  }
}