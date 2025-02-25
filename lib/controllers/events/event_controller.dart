import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/loading_state.dart';

import '../../models/event.dart';
import '../../repositories/database/firebase_firestore_repository.dart';

part 'event_controller.g.dart';

@riverpod
class EventController extends _$EventController {
  @override
  LoadingState build() {
    return const LoadingState(LoadingStateEnum.initial, null);
  }

  Future<void> postEvent(Event event) async {
    state = const LoadingState(LoadingStateEnum.loading, null);
    try {
      final firestoreRepository = ref.watch(firestoreRepositoryProvider);
      final newEvent = event.toJson();
      await firestoreRepository.postRecord('events', event.id, newEvent);
      state = const LoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      print(e);
      state = LoadingState(LoadingStateEnum.error, e);
    }
  }
}
