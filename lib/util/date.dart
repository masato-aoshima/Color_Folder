import 'package:intl/intl.dart';

DateFormat japanDateFormatter = DateFormat('yyyy年M月d日 HH:mm');

// String型のDateTimeを受け取って、yyyy年M月d日 HH:mm　形式の文字列を返す
String getJapaneseDate(String rawDate) {
  final date = DateTime.parse(rawDate);
  return japanDateFormatter.format(date);
}
