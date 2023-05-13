import 'package:intl/intl.dart';

String formatePrice(num number) {
  // return NumberFormat('###,###.##').format(number);
  return NumberFormat.currency(name: '').format(number);
}

String formateDeliveryTime(DateTime dateTime) {
  // return DateFormat.yMMMMd('en_US').format(dateTime);
  return DateFormat('y/MM/d - hh:mm aaa').format(dateTime);
}
