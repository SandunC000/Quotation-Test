import 'package:enhanzer_test/utilities/global_exports.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  static Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Item_Details(
        id INTEGER PRIMARY KEY,
        itemName TEXT,
        price REAL
      )
    ''');

    await db.insert('Item_Details', {'id': 1, 'itemName': 'Item 1', 'price': 50.00});
    await db.insert('Item_Details', {'id': 2, 'itemName': 'Item 2', 'price': 60.00});
    await db.insert('Item_Details', {'id': 3, 'itemName': 'Item 3', 'price': 70.00});
  }

  Future<void> insertItems(Item item) async {
    final db = await database;
    await db.insert(
      'Item_Details',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Item>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Item_Details');
    return List.generate(maps.length, (i) {
      return Item.fromJson(maps[i]);
    });
  }

  Future<void> deleteitem(int id) async {
    final db = await database;
    await db.delete(
      'Item_Details',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
