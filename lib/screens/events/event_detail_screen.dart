import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/controllers/events/users_in_event_controller.dart';
import 'package:sincroniza/models/event.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';
import 'package:sincroniza/widgets/event_details_list.dart';
import 'package:sincroniza/widgets/users_in_event.dart';

import '../../models/app_user.dart';
import 'add_participant_to_event_screen.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  const EventDetailScreen({super.key, required this.event});

  final Event event;

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final usersInEvent =
        ref.watch(usersInEventControllerProvider(widget.event.id));

    List<Widget> eventDetailActions = [
      Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (BuildContext context) {
                  return AddParticipantToEventScreen(
                      eventId: widget.event.id, groupId: widget.event.groupId);
                });
          },
          child: Icon(
            Icons.group_add_rounded,
            color: Theme.of(context).colorScheme.surfaceBright,
          ),
        ),
      ),
    ];

    return usersInEvent.when(data: (List<AppUser> usersList) {
      return Scaffold(
        appBar: CustomAppBar(
          title: widget.event.title,
          showDefaultActions: false,
          customActions: eventDetailActions,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.event.eventDetails != null)
                EventDetailsList(details: widget.event.eventDetails!),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: usersList.isNotEmpty,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Escalação',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: usersList.isNotEmpty,
                child: UsersInEvent(users: usersList),
              ),
            ],
          ),
        ),
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
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
