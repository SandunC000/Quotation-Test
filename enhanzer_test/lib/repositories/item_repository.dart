import 'package:enhanzer_test/utilities/global_exports.dart';

class ItemRepository {
  final DatabaseService _databaseService;

  ItemRepository(this._databaseService);

  Future<void> addItem(Item item) async {
    await _databaseService.insertItems(item);
  }

  Future<List<Item>> getItems() async {
    return await _databaseService.getItems();
  }
}
