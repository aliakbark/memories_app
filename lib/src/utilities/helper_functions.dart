import 'package:intl/intl.dart';

class HelperFunctions {
  static final dateTimeFormat = DateFormat("d MMM yyyy, HH:mm:a");

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
}
