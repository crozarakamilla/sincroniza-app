import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/work_engine/work_schedule_repository.dart';

import '../../models/enums.dart';
import '../../models/event.dart';

part 'ostncs_work_schedule_repository.g.dart';

@riverpod
OstncsWorkScheduleRepository ostncsScheduleRepository(Ref ref, String userId) {
  return OstncsWorkScheduleRepository();
}

class OstncsWorkScheduleRepository extends WorkScheduleRepository {
  OstncsWorkScheduleRepository();

  @override
  Future<Map<String, int>> daysWorkedOnGroup() async {
    int officialDays = 0;
    int extraordinaryDays = 0;
    final List<Event> eventsList = [];
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
  Future<Map<String, double>> userPercentageOfRehearsals(String userId) async {
    Map<String, double> userPercentage = {};
    double officialRehearsalsPercentage = 0;
    double extraordinaryRehearsalsPercentage = 0;
    Map<String, int> userDaysOfRehearsal =
        await userTotalDaysRehearsaled(userId);
    Map<String, int> groupDaysOfWork = await daysWorkedOnGroup();
    officialRehearsalsPercentage =
        userDaysOfRehearsal[CategoryEnum.oficial.toString()]! /
            groupDaysOfWork[CategoryEnum.oficial.toString()]!;
    extraordinaryRehearsalsPercentage =
        userDaysOfRehearsal[CategoryEnum.extraordinario.toString()]! /
            groupDaysOfWork[CategoryEnum.extraordinario.toString()]!;
    userPercentage = {
      CategoryEnum.oficial.toString(): officialRehearsalsPercentage,
      CategoryEnum.extraordinario.toString(): extraordinaryRehearsalsPercentage
    };
    return userPercentage;
  }

  @override
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
