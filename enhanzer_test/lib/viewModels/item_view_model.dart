import 'package:enhanzer_test/utilities/global_exports.dart';

class ItemViewModel extends ChangeNotifier {
  final ItemRepository _itemRepository;
  List<Item> _items = [];

  ItemViewModel(this._itemRepository);

  List<Item> get items => _items;

  Future<void> fetchItems() async {
    _items = await _itemRepository.getItems();
    notifyListeners();
  }

  Future<void> addItem(Item item) async {
    await _itemRepository.addItem(item);
    await fetchItems();
  }
}
