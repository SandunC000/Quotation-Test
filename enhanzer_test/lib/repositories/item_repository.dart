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

  Future<void> addItemDetails(Map<String, dynamic> item) async {
    await _databaseService.insertItemDetails(item);
  }

  Future<List<Map<String, dynamic>>> getItemDetails() async {
    return await _databaseService.getItemDetails();
  }
}
