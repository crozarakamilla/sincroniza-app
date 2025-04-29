import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/controllers/events/events_filtered_by_user.dart';
import 'package:sincroniza/controllers/groups/group_events_controller.dart';

import '../../models/enums.dart';
import '../../models/event.dart';

part 'user_percentage_of_work_controller.g.dart';

@riverpod
class UserPercentageOfWorkController extends _$UserPercentageOfWorkController {
  @override
  FutureOr<Map<String, double>> build(String userId) async {
    return userPercentageOfRehearsals(userId);
  }

  Future<Map<String, int>> daysWorkedOnGroup() async {
    int officialDays = 0;
    int extraordinaryDays = 0;
    final List<Event> eventsList =
        await ref.watch(groupEventsControllerProvider.future);
    for (Event event in eventsList) {
      if (event.category == CategoryEnum.oficial.name.toString()) {
        officialDays += int.parse(event.rehearsalsQuantity!);
      }
      if (event.category == CategoryEnum.extraordinario.name.toString()) {
        extraordinaryDays += int.parse(event.rehearsalsQuantity!);
      }
    }
    return {
      CategoryEnum.oficial.name.toString(): officialDays,
      CategoryEnum.extraordinario.name.toString(): extraordinaryDays
    };
  }

  Future<Map<String, double>> userPercentageOfRehearsals(String userId) async {
    Map<String, double> userPercentage = {};
    double officialRehearsalsPercentage = 0;
    double extraordinaryRehearsalsPercentage = 0;
    Map<String, int> userDaysOfRehearsal =
        await userTotalDaysRehearsaled(userId);
    Map<String, int> groupDaysOfWork = await daysWorkedOnGroup();
    officialRehearsalsPercentage =
        userDaysOfRehearsal[CategoryEnum.oficial.name.toString()]! /
            groupDaysOfWork[CategoryEnum.oficial.name.toString()]!;
    extraordinaryRehearsalsPercentage =
        userDaysOfRehearsal[CategoryEnum.extraordinario.name.toString()]! /
            groupDaysOfWork[CategoryEnum.extraordinario.name.toString()]!;
    userPercentage = {
      CategoryEnum.oficial.name.toString():
          double.parse((officialRehearsalsPercentage * 100).toStringAsFixed(2)),
      CategoryEnum.extraordinario.name.toString(): double.parse(
          (extraordinaryRehearsalsPercentage * 100).toStringAsFixed(2))
    };
    return userPercentage;
  }

  Future<Map<String, int>> userTotalDaysRehearsaled(String userId) async {
    int officialDaysRehearsaled = 0;
    int extraordinaryDaysRehearsaled = 0;
    final List<Event> eventsList =
        await ref.watch(eventsFilteredByUserProvider(userId).future);
    for (Event event in eventsList) {
      if (event.category == CategoryEnum.oficial.name.toString()) {
        officialDaysRehearsaled += int.parse(event.rehearsalsQuantity!);
      }
      if (event.category == CategoryEnum.extraordinario.name.toString()) {
        extraordinaryDaysRehearsaled += int.parse(event.rehearsalsQuantity!);
      }
    }
    return {
      CategoryEnum.oficial.name.toString(): officialDaysRehearsaled,
      CategoryEnum.extraordinario.name.toString(): extraordinaryDaysRehearsaled
    };
  }
}
