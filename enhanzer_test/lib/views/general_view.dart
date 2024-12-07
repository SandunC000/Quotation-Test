import 'package:enhanzer_test/utilities/global_exports.dart';

class GeneralView extends StatefulWidget {
  const GeneralView({super.key});

  @override
  State<GeneralView> createState() => _GeneralViewState();
}

class _GeneralViewState extends State<GeneralView> {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  final List<Map<String, dynamic>> itemList = [];

  @override
  Widget build(BuildContext context) {
    final itemViewModel = Provider.of<ItemViewModel>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          _amountContainer(),
          _dataField(context, itemViewModel),
        ],
      ),
    );
  }

  Widget _amountContainer() {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF02528F),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Net Amount',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              currencyFormatter(1000.00),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dataField(BuildContext context, ItemViewModel itemViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<Item>(
          hint: const Text('Items'),
          items: itemViewModel.items.map((item) {
            return DropdownMenuItem<Item>(
              value: item,
              child: Text(item.itemName),
            );
          }).toList(),
          onChanged: (Item? selectedItem) {
            if (selectedItem != null) {
              itemNameController.text = selectedItem.itemName;
              priceController.text = selectedItem.price.toString();
            }
          },
        ),
        _textField('Reasons', reasonController),
        _textField('Price', priceController,
            keyboardType: TextInputType.number),
        _quantityAndDiscountFields(),
      ],
    );
  }

  Widget _textField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: controller.text,
              isDense: true,
              contentPadding: const EdgeInsets.only(top: 0, bottom: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityAndDiscountFields() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: _textField('Qty', quantityController,
              keyboardType: TextInputType.number),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _textField('Discount %', discountController,
              keyboardType: TextInputType.number),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _addItem();
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: const Color(0xFF02528F),
                    borderRadius: BorderRadius.circular(3)),
                child: const Center(
                  child: Text(
                    'ADD',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _addItem() {
    try {
      double price = double.parse(priceController.text);
      int quantity = int.parse(quantityController.text);
      double discount = double.parse(discountController.text);
      String reason = reasonController.text;

      double amount = (price * quantity) * (100 - discount) / 100;

      setState(() {
        itemList.add({
          'itemName': itemNameController.text,
          'price': price,
          'quantity': quantity,
          'discount': discount,
          'reason': reason,
          'amount': amount,
        });
      });

      _clearControllers();
    } catch (e) {
      rethrow;
    }
  }

  void _clearControllers() {
    itemNameController.clear();
    priceController.clear();
    quantityController.clear();
    discountController.clear();
    reasonController.clear();
  }
}
