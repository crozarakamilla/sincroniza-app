import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/controllers/events/event_controller.dart';
import 'package:sincroniza/models/app_user.dart';

import '../../controllers/events/users_in_event_controller.dart';
import '../../controllers/groups/users_in_group_controller.dart';
import '../../widgets/add_users_to_event.dart';
import '../../widgets/loading_widget.dart';

class AddParticipantToEventScreen extends ConsumerStatefulWidget {
  const AddParticipantToEventScreen({
    super.key,
    required this.eventId,
    required this.groupId,
  });

  final String eventId;
  final String groupId;

  @override
  ConsumerState<AddParticipantToEventScreen> createState() =>
      _AddParticipantToEventScreenState();
}

class _AddParticipantToEventScreenState
    extends ConsumerState<AddParticipantToEventScreen> {
  BuildContext? _progressIndicatorContext;
  bool showTextField = false;
  TextEditingController _searchController = TextEditingController();
  String? selectedUser;
  List<String> usersToAdd = [];
  List<String> usersPresentInEvent = [];

  void addUserToEvent(String userId) {
    if (usersToAdd.contains(userId)) {
      usersToAdd.remove(userId);
    } else if (!usersPresentInEvent.contains(userId)) {
      usersToAdd.add(userId);
    }
    if (usersPresentInEvent.contains(userId)) {
      usersPresentInEvent.remove(userId);
    } else {
      usersPresentInEvent.add(userId);
    }
  }

  void _saveUsers(BuildContext context) async {
    showDialog(
        context: context,
        builder: (ctx) {
          _progressIndicatorContext = ctx;
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    for (String existingUserId in usersPresentInEvent) {
      if (!usersToAdd.contains(existingUserId)) {
        usersToAdd.add(existingUserId);
      }
    }

    await ref
        .read(eventControllerProvider.notifier)
        .addUserToEvent(widget.eventId, usersToAdd);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Participantes atualizados!'),
        ),
      );

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    if (_progressIndicatorContext != null &&
        _progressIndicatorContext!.mounted) {
      _progressIndicatorContext = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usersInEvent =
        ref.watch(usersInEventControllerProvider(widget.eventId));

    usersInEvent.whenData((data) {
      for (AppUser user in data) {
        if (!usersPresentInEvent.contains(user.uid)) {
          usersPresentInEvent.add(user.uid);
        }
      }
    });
    final users = ref.watch(usersInGroupControllerProvider(widget.groupId));
    return users.when(data: (List<AppUser> availableUsers) {
      final filteredUsers = availableUsers.where((user) {
        final query = _searchController.text.toLowerCase();
        return user.name.toLowerCase().contains(query);
      }).toList();
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            _saveUsers(context);
          },
          child: const Icon(
            Icons.check,
            weight: 60,
          ),
        ),
        appBar: !showTextField
            ? AppBar(
                title: Text(
                  'Adicionar Participantes',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                iconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                actions: [
                  IconButton(
                    icon: Icon(
                      showTextField ? Icons.close : Icons.search,
                      color: Theme.of(context).colorScheme.surfaceBright,
                    ),
                    onPressed: () {
                      setState(() {
                        showTextField = !showTextField;
                        if (!showTextField) {
                          _searchController.clear();
                        }
                      });
                    },
                  ),
                ],
              )
            : null,
        backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Visibility(
                visible: showTextField,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Procurar nomes',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.surfaceBright,
                      ),
                      fillColor: Theme.of(context).colorScheme.inversePrimary,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2), // Focus effect
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      prefixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showTextField = !showTextField;
                            if (!showTextField) {
                              _searchController.clear();
                            }
                          });
                        },
                        child: Icon(
                          Icons.arrow_back,
                          weight: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surfaceBright,
                    ),
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              AddUsersToEvent(
                users: filteredUsers,
                onUsertap: addUserToEvent,
                usersInEvent: usersPresentInEvent,
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
      return const LoadingWidget();
    });
  }
}
