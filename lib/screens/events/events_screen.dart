import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/controllers/events/event_controller.dart';
import 'package:sincroniza/models/event.dart';
import 'package:sincroniza/screens/events/choose_new_event_input_type.dart';
import 'package:sincroniza/screens/events/event_detail_screen.dart';
import 'package:sincroniza/screens/events/new_event_form_screen.dart';
import 'package:sincroniza/screens/events/new_event_input_list.dart';
import 'package:sincroniza/widgets/event_card.dart';

import '../../controllers/groups/user_groups_controller.dart';
import '../../models/group.dart';
import '../../repositories/user/firebase_auth_repository.dart';
import '../../widgets/loading_widget.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  void selectEvent(BuildContext context, Event event) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EventDetailScreen(
          event: event,
        ),
      ),
    );
  }

  void setInputType(BuildContext context, inputType) {
    Navigator.of(context).pop();
    if (inputType == 'single') {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (BuildContext context) {
            return const NewEventFormScreen();
          });
    } else {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (BuildContext context) {
            return NewEventInputList();
          });
    }
  }

  void customDialog(BuildContext context) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) {
          return ChooseNewEventInputType(
            selectInputType: setInputType,
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Group> userGroups = [];
    final groups = ref.watch(userGroupsControllerProvider(
        ref.read(authRepositoryProvider).currentUser!.uid));

    groups.whenData((data) => userGroups = data);

    FloatingActionButton floatingButton = FloatingActionButton(
      onPressed: () {
        customDialog(context);
      },
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: const Icon(
        Icons.add,
        weight: 50,
      ),
    );

    final events = ref.watch(eventControllerProvider);
    return events.when(data: (List<Event> events) {
      if (events.isEmpty) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Os seus grupos ainda não têm eventos.',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 32,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Crie um novo evento.',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton:
              Visibility(visible: userGroups.isNotEmpty, child: floatingButton),
        );
      }

      return Scaffold(
        body: ListView.builder(
          itemCount: events.length,
          itemBuilder: (ctx, index) => EventCard(
            event: events[index],
            onSelectEvent: (event) {
              selectEvent(context, event);
            },
          ),
        ),
        floatingActionButton:
            Visibility(visible: userGroups.isNotEmpty, child: floatingButton),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ocorreu um erro ao carregar os eventos!',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 32,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Tente novamente mais tarde.',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }, loading: () {
      return const LoadingWidget();
    });
  }
}
