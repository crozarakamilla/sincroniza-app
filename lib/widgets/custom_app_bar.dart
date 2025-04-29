import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/controllers/menu/menu_controller.dart';

import '../controllers/users/firebase_auth_controller.dart';
import '../screens/calendar/filter_screen.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.title,
    required this.showDefaultActions,
    this.customActions = const [],
  });

  final String title;
  final bool showDefaultActions;
  List<Widget>? customActions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PopupMenuEntry<String>> menuItems = ref.read(menuControllerProvider);
    List<Widget> actions = showDefaultActions
        ? [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    useSafeArea: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    builder: (BuildContext context) {
                      return const FilterScreen();
                    });
              },
              child: Icon(
                Icons.filter_alt_sharp,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: PopupMenuButton<String>(
                onSelected: (String result) async {
                  print(result);
                  if (result == 'logout') {
                    await ref.read(authControllerProvider.notifier).signOut();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return menuItems;
                },
                child: Container(
                  height: 36,
                  width: 48,
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).colorScheme.surfaceBright,
                  ),
                ),
              ),
            )
          ]
        : customActions!;
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
      actions: actions,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
