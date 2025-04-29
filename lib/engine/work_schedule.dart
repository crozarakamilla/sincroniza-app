import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class WorkSchedule {
  Future<Map<String, int>> daysWorkedOnGroup(Ref ref, String groupId);

  Future<List<Map<String, double>>> userPercentageOfRehearsals(
      Ref ref, String userId, String groupId);

  Future<Map<String, int>> userTotalDaysRehearsaled(Ref ref, String userId);
}
