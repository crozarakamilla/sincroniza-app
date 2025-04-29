import 'package:riverpod_annotation/riverpod_annotation.dart';

final currentDateProvider = Provider<Map<String, DateTime>>((ref) {
  DateTime now = DateTime.now();
  return {
    "startDate": DateTime(now.year, 1, 1),
    "endDate": DateTime(now.year, 12, 31),
  };
});
