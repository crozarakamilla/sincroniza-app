import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/repositories/menu/menu_repository.dart';

part 'menu_controller.g.dart';

enum MenusNames { events, groups, calendar, leaves }

Map menusMaps = {
  MenusNames.events: "events",
  MenusNames.groups: "groups",
  MenusNames.calendar: "calendar",
  MenusNames.leaves: "leaves"
};

@riverpod
class MenuController extends _$MenuController {
  @override
  List<PopupMenuEntry<String>> build() {
    return ref.read(menuRepositoryProvider).menuList();
  }
}

@riverpod
class ScreenNameController extends _$ScreenNameController {
  @override
  String build() {
    return ref.read(screenNameRepositoryProvider).currentScreen;
  }

  String currentScreenName() {
    return ref.read(screenNameRepositoryProvider).currentScreen;
  }

  void changeScreenName(String newScreenName) {
    ref.read(screenNameRepositoryProvider).changeScreenName(newScreenName);
  }
}
