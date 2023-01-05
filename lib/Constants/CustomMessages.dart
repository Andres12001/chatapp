import 'package:easy_localization/easy_localization.dart';
import 'package:get_time_ago/get_time_ago.dart';

class CustomMessages implements Messages {
  @override
  String prefixAgo() => '';

  @override
  String suffixAgo() => 'ago'.tr();

  @override
  String secsAgo(int seconds) => '$seconds ${'seconds'.tr()}';

  @override
  String minAgo(int minutes) => 'aminute'.tr();

  @override
  String minsAgo(int minutes) => '$minutes ${'minutes'.tr()}';

  @override
  String hourAgo(int minutes) => 'anhour'.tr();

  @override
  String hoursAgo(int hours) => '$hours ${'hours'.tr()}';

  @override
  String dayAgo(int hours) => 'aday'.tr();

  @override
  String daysAgo(int days) => '$days ${'days'.tr()}';

  @override
  String wordSeparator() => ' ';
}
