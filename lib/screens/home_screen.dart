import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/controllers/menu/menu_controller.dart';
import 'package:sincroniza/screens/calendar_screen.dart';
import 'package:sincroniza/screens/events/events_screen.dart';
import 'package:sincroniza/screens/groups/groups_screen.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.read(screenNameControllerProvider.notifier).changeScreenName('events');
    String activePageTitle = 'Eventos';
    Widget activePage = const EventsScreen();

    if (_selectedPageIndex == 0) {
      ref
          .read(screenNameControllerProvider.notifier)
          .changeScreenName('events');
      activePageTitle = 'Eventos';
      activePage = const EventsScreen();
    }
    if (_selectedPageIndex == 1) {
      ref
          .read(screenNameControllerProvider.notifier)
          .changeScreenName('groups');
      activePageTitle = 'Grupos';
      activePage = const GroupsScreen();
    }

    if (_selectedPageIndex == 2) {
      ref
          .read(screenNameControllerProvider.notifier)
          .changeScreenName('calendar');
      activePageTitle = 'Calendário';
      activePage = const CalendarScreen();
    }
    if (_selectedPageIndex == 3) {
      ref
          .read(screenNameControllerProvider.notifier)
          .changeScreenName('leaves');
      activePageTitle = 'Licenças';
      activePage = const CalendarScreen();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: activePageTitle,
        showDefaultActions: true,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
          opacity: 1,
        ),
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
          opacity: 1,
          size: 30,
        ),
        selectedLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_available_outlined,
            ),
            label: "Eventos",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.groups,
            ),
            label: "Grupos",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month_outlined,
            ),
            label: "Calendário",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.outbound_outlined,
            ),
            label: "Licenças",
          ),
        ],
      ),
    );
  }
}
