import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/enums.dart';
import '../../models/event.dart';

part 'ostncs_work_schedule_controller.g.dart';

@riverpod
class OstncsWorkScheduleController extends _$OstncsWorkScheduleController {
  @override
  Map<String, double> build() {
    return {"Official": 2.0, "Extraordinary": 3.0};
  }

  Future<Map<String, int>> daysWorkedOnGroup(String groupId) async {
    return {
      CategoryEnum.oficial.toString(): 2,
      CategoryEnum.extraordinario.toString(): 3
    };
    /**
        return ref
        .read(ostncsScheduleRepositoryProvider(userId, groupId))
        .daysWorkedOnGroup(groupId);
     **/
  }

  Future<List<Map<String, double>>> userPercentageOfRehearsals(
      String userId, String groupId) async {
    List<Map<String, double>> userPercentage = [];
    double officialRehearsalsPercentage = 0;
    double extraordinaryRehearsalsPercentage = 0;
    Map<String, int> userDaysOfRehearsal =
        await userTotalDaysRehearsaled(userId);
    Map<String, int> groupDaysOfWork = await daysWorkedOnGroup(groupId);
    officialRehearsalsPercentage =
        userDaysOfRehearsal[CategoryEnum.oficial.toString()]! /
            groupDaysOfWork[CategoryEnum.oficial.toString()]!;
    extraordinaryRehearsalsPercentage =
        userDaysOfRehearsal[CategoryEnum.extraordinario.toString()]! /
            groupDaysOfWork[CategoryEnum.extraordinario.toString()]!;
    userPercentage.add({
      CategoryEnum.oficial.toString(): officialRehearsalsPercentage,
      CategoryEnum.extraordinario.toString(): extraordinaryRehearsalsPercentage
    });
    return userPercentage;
  }

  Future<Map<String, int>> userTotalDaysRehearsaled(String userId) async {
    int officialDaysRehearsaled = 0;
    int extraordinaryDaysRehearsaled = 0;
    List<Event> eventsList = [];
    for (Event event in eventsList) {
      if (event.category == CategoryEnum.oficial.toString()) {
        officialDaysRehearsaled += int.parse(event.rehearsalsQuantity!);
      }
      if (event.category == CategoryEnum.extraordinario.toString()) {
        extraordinaryDaysRehearsaled += int.parse(event.rehearsalsQuantity!);
      }
    }
    return {
      CategoryEnum.oficial.toString(): officialDaysRehearsaled,
      CategoryEnum.extraordinario.toString(): extraordinaryDaysRehearsaled
    };
  }
}
