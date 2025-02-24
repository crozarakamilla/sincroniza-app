import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/users/auth_provider.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withValues()
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 0,
                    bottom: 0,
                    left: 5,
                    right: 5,
                  ),
                  width: 30,
                  child: Image.asset('assets/images/ic_bonina.png'),
                ),
                const SizedBox(width: 12),
                Text(
                  'Sincroniza',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.event,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Eventos',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 22,
                  ),
            ),
            onTap: () {
              context.goNamed('events');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.event,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Novo evento',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 22,
                  ),
            ),
            onTap: () {
              context.goNamed('new-event');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.percent_outlined,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Porcentagens',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 22,
                  ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Sair',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 22,
                  ),
            ),
            onTap: () {
              authController.signOut();
              context.goNamed('auth');
            },
          ),
        ],
      ),
    );
  }
}
