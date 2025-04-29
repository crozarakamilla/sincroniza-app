abstract class WorkScheduleRepository {
  Future<Map<String, int>> daysWorkedOnGroup();

  Future<Map<String, double>> userPercentageOfRehearsals(String userId);

  Future<Map<String, int>> userTotalDaysRehearsaled(String userId);
}
