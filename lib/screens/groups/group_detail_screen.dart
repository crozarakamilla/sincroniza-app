import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/controllers/groups/users_in_group_controller.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';
import 'package:sincroniza/widgets/loading_widget.dart';
import 'package:sincroniza/widgets/users_in_event.dart';

import '../../models/app_user.dart';
import '../../models/group.dart';

class GroupDetailScreen extends ConsumerWidget {
  const GroupDetailScreen({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersInGroupControllerProvider(group.id));
    return users.when(data: (List<AppUser> users) {
      return Scaffold(
        appBar: CustomAppBar(
          title: group.name,
          showDefaultActions: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Participantes',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                  ),
                ],
              ),
              UsersInEvent(users: users),
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
