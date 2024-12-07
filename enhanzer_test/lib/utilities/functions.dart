import 'package:enhanzer_test/utilities/global_exports.dart';

String currencyFormatter(double? value) {
  return NumberFormat.currency(decimalDigits: 2, symbol: '\$').format(value);
}
