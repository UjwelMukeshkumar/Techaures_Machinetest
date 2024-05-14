import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper instance = DBHelper._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'cart_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE cart(id INTEGER PRIMARY KEY, name TEXT, price REAL, quantity INTEGER, image TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertCartItem(Map<String, dynamic> cartItem) async {
    final db = await database;
    await db.insert('cart', cartItem,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await database;
    return db.query('cart');
  }

  Future<void> deleteCartItem(int id) async {
    final db = await database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}

class CartDatabaseHelper {
  static final _databaseName = "cart.db";
  static final _databaseVersion = 1;

  static final table = 'cart';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnPrice = 'price';
  static final columnQuantity = 'quantity';
  static final columnImageUrl = 'imageUrl';

  // make this a singleton class
  CartDatabaseHelper._privateConstructor();
  static final CartDatabaseHelper instance =
      CartDatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnPrice REAL NOT NULL,
        $columnQuantity INTEGER NOT NULL,
        $columnImageUrl TEXT NOT NULL
      )
      ''');
  }

  // Helper methods

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
