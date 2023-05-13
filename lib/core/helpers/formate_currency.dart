import 'package:intl/intl.dart';

String formateCurrency(num number) {
  return NumberFormat.currency(
    decimalDigits: 2,
    symbol: 'EGP-',
    locale: "en_US",
  ).format(number).split("-").reversed.join(" ");
}

String formateCurrencyNumber(num number) {
  return NumberFormat.currency(
    decimalDigits: 0,
    symbol: '',
    locale: "en_US",
  ).format(number);
}

extension FormateCurrency on num {
  String formattedCurrency() => formateCurrency(this);
  String formattedCurrencyNumber() => formateCurrencyNumber(this);
}
