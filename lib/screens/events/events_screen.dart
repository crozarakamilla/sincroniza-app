import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/controllers/events/event_controller.dart';
import 'package:sincroniza/models/event.dart';
import 'package:sincroniza/repositories/events/events_filtered.dart';
import 'package:sincroniza/screens/events/choose_new_event_input_type.dart';
import 'package:sincroniza/screens/events/event_detail_screen.dart';
import 'package:sincroniza/screens/events/new_event_form_screen.dart';
import 'package:sincroniza/screens/events/new_event_input_list.dart';
import 'package:sincroniza/widgets/delete_event_dialog.dart';
import 'package:sincroniza/widgets/event_card.dart';

import '../../controllers/events/users_in_event_controller.dart';
import '../../controllers/groups/user_groups_controller.dart';
import '../../models/group.dart';
import '../../repositories/user/firebase_auth_repository.dart';
import '../../widgets/loading_widget.dart';
import 'add_participant_to_event_screen.dart';
import 'edit_event_screen.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  BuildContext? _progressIndicatorContext;

  void selectEvent(BuildContext context, Event event) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EventDetailScreen(
          event: event,
        ),
      ),
    );
  }

  void editEvent(BuildContext context, Event event) async {
    final updatedEventData = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EditEventScreen(
          event: event,
        ),
      ),
    );

    if (updatedEventData != null) {
      showDialog(
          context: context,
          builder: (ctx) {
            _progressIndicatorContext = ctx;
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await ref
          .read(eventControllerProvider.notifier)
          .patchEvent(updatedEventData);

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Evento atualizado com sucesso!'),
        ),
      );
    }
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

  void onAddParticipants(BuildContext context, Event event) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (BuildContext context) {
          return AddParticipantToEventScreen(
            eventId: event.id!,
            groupId: event.groupId!,
          );
        });
    ref.watch(usersInEventControllerProvider(event.id!));
  }

  void newEventDialog(BuildContext context) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) {
          return ChooseNewEventInputType(
            selectInputType: setInputType,
          );
        });
  }

  void onDeleteEvent(BuildContext context, Event event) async {
    final deleteEvent = await showDialog(
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) {
          return DeleteEventDialog();
        });
    if (deleteEvent == true) {
      showDialog(
          context: context,
          builder: (ctx) {
            _progressIndicatorContext = ctx;
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      await ref.read(eventControllerProvider.notifier).deleteEvent(event);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Evento excluído com sucesso!'),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Group> userGroups = [];
    final groups = ref.watch(userGroupsControllerProvider(
        ref.watch(authRepositoryProvider).currentUser!.uid));

    groups.whenData((data) => userGroups = data);

    FloatingActionButton floatingButton = FloatingActionButton(
      onPressed: () {
        newEventDialog(context);
      },
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Icon(
        Icons.add,
        weight: 50,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );

    final events = ref.watch(filteredEventsProvider);
    return events.when(data: (List<Event> events) {
      if (events.isEmpty) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Os seus naipes ainda não têm eventos.',
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
        backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
        body: ListView.builder(
          itemCount: events.length,
          itemBuilder: (ctx, index) => EventCard(
            event: events[index],
            onSelectEvent: (event) {
              selectEvent(context, event);
            },
            onEditEvent: (event) {
              editEvent(context, event);
            },
            onAddParticipants: (event) {
              onAddParticipants(context, event);
            },
            onDeleteEvent: (event) {
              onDeleteEvent(context, event);
            },
          ),
        ),
        floatingActionButton:
            Visibility(visible: userGroups.isNotEmpty, child: floatingButton),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
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
