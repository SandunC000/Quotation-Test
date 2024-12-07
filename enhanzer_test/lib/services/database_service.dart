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
    String path = join(await getDatabasesPath(), 'items_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Items(
        id INTEGER PRIMARY KEY,
        itemName TEXT,
        price REAL
      )
    ''');

    await db.insert('Items', {'id': 1, 'itemName': 'Item 1', 'price': 50.00});
    await db.insert('Items', {'id': 2, 'itemName': 'Item 2', 'price': 60.00});
    await db.insert('Items', {'id': 3, 'itemName': 'Item 3', 'price': 70.00});

    await db.execute('''
      CREATE TABLE Items_Details(
        id INTEGER PRIMARY KEY,
        itemName TEXT,
        reason TEXT,
        price REAL,
        quantity INTEGER,
        discount REAL,
        netAmount REAL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE Items_Details ADD COLUMN reason TEXT
      ''');
    }
  }

  Future<void> insertItems(Item item) async {
    final db = await database;
    await db.insert(
      'Items',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertItemDetails(Map<String, dynamic> item) async {
    final db = await database;
    await db.insert(
      'Items_Details',
      item,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Item>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Items');
    return List.generate(maps.length, (i) {
      final item = Item.fromJson(maps[i]);
      return item;
    });
  }

  Future<List<Map<String, dynamic>>> getItemDetails() async {
    final db = await database;
    return await db.query('Items_Details');
  }
}
