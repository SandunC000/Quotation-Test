import 'package:enhanzer_test/utilities/global_exports.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({super.key});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  @override
  Widget build(BuildContext context) {
    final itemViewModel = Provider.of<ItemViewModel>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: DataTable(
          columnSpacing: 0,
          horizontalMargin: 16,
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          dataTextStyle: const TextStyle(
            color: Colors.black87,
          ),
          headingRowColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              return Colors.grey[300]!;
            },
          ),
          dataRowColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.blue[50]!;
              }
              return Colors.white;
            },
          ),
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Price')),
          ],
          rows: itemViewModel.items.map((item) {
            return DataRow(
              cells: [
                DataCell(Text(item.itemName)),
                DataCell(Text(currencyFormatter(item.price))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
