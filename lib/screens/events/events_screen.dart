import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/controllers/events/event_controller.dart';
import 'package:sincroniza/models/event.dart';
import 'package:sincroniza/screens/events/event_detail_screen.dart';
import 'package:sincroniza/screens/events/new_event_screen.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';
import 'package:sincroniza/widgets/custom_drawer.dart';
import 'package:sincroniza/widgets/event_card.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventControllerProvider);
    return events.when(data: (List<Event> events) {
      return Scaffold(
        appBar: const CustomAppBar(title: 'Eventos'),
        drawer: const CustomDrawer(),
        body: ListView.builder(
          itemCount: events.length,
          itemBuilder: (ctx, index) => EventCard(
            event: events[index],
            onSelectEvent: (event) {
              selectEvent(context, event);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext ctx) {
                  return const NewEventScreen();
                });
          },
          child: const Icon(Icons.add),
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return Center(
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
      );
    }, loading: () {
      return const Scaffold(
        appBar: CustomAppBar(title: 'Eventos'),
        drawer: CustomDrawer(),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
