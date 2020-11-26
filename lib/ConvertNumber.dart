import 'package:intl/intl.dart';

class ConvertNumber {
  String convertNumber(String number) {
    var f = new NumberFormat("###,##0.0#", "pt_BR");
    var value = f.format(double.parse(number));
    /*var convert = double.parse(number);
    var value = convert.toStringAsFixed(2).replaceAll(".", ",");
    var f = new NumberFormat("###.0#", "pt_BR");
    f.format(value);*/
    print(value);
    return value;
  }
}
