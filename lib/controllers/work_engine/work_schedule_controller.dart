abstract class WorkScheduleController {
  Future<Map<String, int>> daysWorkedOnGroup(String groupId);

  Future<List<Map<String, double>>> userPercentageOfRehearsals(
      String userId, String groupId);

  Future<Map<String, int>> userTotalDaysRehearsaled(String userId);
}
