import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/controllers/groups/group_controller.dart';
import 'package:sincroniza/models/group.dart';
import 'package:sincroniza/widgets/loading_widget.dart';

import '../../widgets/group_card.dart';
import 'group_detail_screen.dart';
import 'new_group_screen.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  void selectGroup(BuildContext context, Group group) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => GroupDetailScreen(
          group: group,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupControllerProvider);
    return groups.when(data: (List<Group> groups) {
      if (groups.isEmpty) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Você ainda não participa de nenhum naipe!',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 32,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Crie um novo naipe ou aceite o convite para participar de um.',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (BuildContext context) {
                    return const NewGroupScreen();
                  });
            },
            child: const Icon(Icons.add),
          ),
        );
      }
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
        body: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (ctx, index) => GroupCard(
            group: groups[index],
            onSelectGroup: (group) {
              selectGroup(context, group);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (BuildContext context) {
                  return const NewGroupScreen();
                });
          },
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
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
                  'Ocorreu um erro ao carregar os groupos!',
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
