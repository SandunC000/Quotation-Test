import 'package:enhanzer_test/utilities/global_exports.dart';

class ItemViewModel extends ChangeNotifier {
  final ItemRepository _itemRepository;
  List<Item> _items = [];
  List<Map<String, dynamic>> _itemDetails = [];

  ItemViewModel(this._itemRepository);

  List<Item> get items => _items;
  List<Map<String, dynamic>> get itemDetails => _itemDetails;

  Future<void> fetchItems() async {
    _items = await _itemRepository.getItems();
    notifyListeners();
  }

  Future<void> fetchItemDetails() async {
    _itemDetails = await _itemRepository.getItemDetails();
    notifyListeners();
  }

  Future<void> addItemDetails(Map<String, dynamic> item) async {
    await _itemRepository.addItemDetails(item);
    await fetchItemDetails();
  }
}
