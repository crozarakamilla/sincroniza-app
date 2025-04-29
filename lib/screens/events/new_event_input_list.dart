import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sincroniza/screens/events/edit_event_screen.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';
import 'package:uuid/uuid.dart';

import '../../controllers/ai_utils/ai_utils_event_controller.dart';
import '../../controllers/events/event_controller.dart';
import '../../controllers/groups/user_groups_controller.dart';
import '../../models/event.dart';
import '../../models/group.dart';
import '../../repositories/user/firebase_auth_repository.dart';
import '../../routing/app_route_enum.dart';
import '../../widgets/event_card.dart';

class NewEventInputList extends ConsumerStatefulWidget {
  const NewEventInputList({super.key});

  @override
  ConsumerState<NewEventInputList> createState() => _NewEventInputListState();
}

class _NewEventInputListState extends ConsumerState<NewEventInputList> {
  var uuid = const Uuid();
  TextEditingController _controller = TextEditingController();
  BuildContext? _progressIndicatorContext;
  List<Group> userGroups = [];
  String? selectedGroup;

  List<Event> eventsList = [];

  void _submit(BuildContext context) async {
    if (_controller.text != '') {
      showDialog(
          context: context,
          builder: (ctx) {
            _progressIndicatorContext = ctx;
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      var events = await ref
          .read(aiUtilsEventControllerProvider.notifier)
          .getEventsFromList(_controller.text,
              userGroups.length == 1 ? userGroups.first.id : selectedGroup!);

      setState(() {
        eventsList = events;
      });

      Navigator.of(context).pop();
    }
  }

  void _saveEvents(BuildContext context) async {
    showDialog(
        context: context,
        builder: (ctx) {
          _progressIndicatorContext = ctx;
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    final eventController = ref.read(eventControllerProvider.notifier);
    for (Event event in eventsList) {
      event.id = uuid.v4();
      event.eventDate = DateFormat('dd/MM/yyyy')
          .parse(event.eventDay != '' ? event.eventDay! : '');
      await eventController.postEvent(event);
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Eventos adicionados!'),
        ),
      );

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    if (_progressIndicatorContext != null &&
        _progressIndicatorContext!.mounted) {
      context.goNamed(AppRoutes.events.name);
      _progressIndicatorContext = null;
    }
    super.dispose();
  }

  void selectEvent(BuildContext context, Event event) async {
    final updatedEventData = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EditEventScreen(
          event: event,
        ),
      ),
    );
    if (updatedEventData != null) {
      Event? eventToUpdate = eventsList.firstWhere(
        (event) {
          if (event.id == updatedEventData.id) {
            return true;
          }
          return false;
        },
      );
      setState(() {
        eventToUpdate.title = updatedEventData.title;
        eventToUpdate.eventDay = updatedEventData.eventDay;
        eventToUpdate.startTime = updatedEventData.startTime;
        eventToUpdate.location = updatedEventData.location;
        eventToUpdate.category = updatedEventData.category;
        eventToUpdate.groupId = updatedEventData.groupId;
        eventToUpdate.eventDetails = updatedEventData.eventDetails;
        eventToUpdate.conductor = updatedEventData.conductor;
        eventToUpdate.soloist = updatedEventData.soloist;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final groups = ref.watch(userGroupsControllerProvider(
        ref.read(authRepositoryProvider).currentUser!.uid));

    groups.whenData((data) => userGroups = data);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
      appBar: CustomAppBar(title: "Inserir eventos", showDefaultActions: false),
      floatingActionButton: Visibility(
        visible: eventsList.isNotEmpty,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            _saveEvents(context);
          },
          child: const Icon(
            Icons.check,
            weight: 60,
          ),
        ),
      ),
      body: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          child: eventsList.isEmpty
              ? SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: userGroups.length == 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Naipe: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                              ),
                              Text(
                                userGroups.length == 1
                                    ? userGroups.first.name
                                    : '',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: userGroups.length > 1,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Naipe',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                                  width: 2), // Focus effect
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                          ),
                          value: selectedGroup,
                          items: userGroups.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.id,
                              child: Text(entry.name),
                            );
                          }).toList(),
                          onChanged: (String? newGroup) {
                            setState(() {
                              selectedGroup = newGroup;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {}
                            return null;
                          },
                          onSaved: (value) {
                            selectedGroup = value;
                          },
                        ),
                      ),
                      TextField(
                        controller: _controller,
                        minLines: 15,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.none,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _submit(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          'Adicionar',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.surfaceBright,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.hardEdge,
                      elevation: 1,
                      color: Theme.of(context).colorScheme.secondaryFixed,
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            'Selecione o evento para revisar os dados. Se estiver tudo certo, clique em salvar.'),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: eventsList.length,
                        itemBuilder: (ctx, index) => EventCard(
                          event: eventsList[index],
                          onSelectEvent: (event) {
                            selectEvent(context, event);
                          },
                          onEditEvent: (event) {
                            selectEvent(context, event);
                          },
                          onDeleteEvent: (event) {
                            eventsList.remove(event);
                          },
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }
}
