import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/engine/work_schedule.dart';
import 'package:sincroniza/models/enums.dart';

import '../controllers/groups/group_controller.dart';
import '../models/event.dart';

class OstncsWorkSchedule extends WorkSchedule {
  @override
  Future<Map<String, int>> daysWorkedOnGroup(Ref ref, String groupId) async {
    int officialDays = 0;
    int extraordinaryDays = 0;
    final List<Event> eventsList = await ref
        .read(groupControllerProvider.notifier)
        .fetchGroupEvents(groupId);
    for (Event event in eventsList) {
      if (event.category == CategoryEnum.oficial.toString()) {
        officialDays += int.parse(event.rehearsalsQuantity!);
      }
      if (event.category == CategoryEnum.extraordinario.toString()) {
        extraordinaryDays += int.parse(event.rehearsalsQuantity!);
      }
    }
    return {
      CategoryEnum.oficial.toString(): officialDays,
      CategoryEnum.extraordinario.toString(): extraordinaryDays
    };
  }

  @override
  Future<List<Map<String, double>>> userPercentageOfRehearsals(
      Ref ref, String userId, String groupId) async {
    List<Map<String, double>> userPercentage = [];
    double officialRehearsalsPercentage = 0;
    double extraordinaryRehearsalsPercentage = 0;
    Map<String, int> userDaysOfRehearsal =
        await userTotalDaysRehearsaled(ref, userId);
    Map<String, int> groupDaysOfWork = await daysWorkedOnGroup(ref, groupId);
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

  Future<Map<String, int>> userTotalDaysRehearsaled(
      Ref ref, String userId) async {
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
