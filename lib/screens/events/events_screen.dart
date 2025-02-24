import 'package:flutter/material.dart';
import 'package:sincroniza/dummy/dummy_data.dart';
import 'package:sincroniza/models/event.dart';
import 'package:sincroniza/screens/events/event_detail_screen.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';
import 'package:sincroniza/widgets/custom_drawer.dart';
import 'package:sincroniza/widgets/event_card.dart';

class EventsScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final List<Event> events = eventsList;

    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Ainda não existem eventos cadastrados!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tente selecionar outra data!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );

    if (events.isNotEmpty) {
      content = ListView.builder(
        itemCount: events.length,
        itemBuilder: (ctx, index) => EventCard(
          event: events[index],
          onSelectEvent: (event) {
            selectEvent(context, event);
          },
        ),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'Eventos'),
      drawer: const CustomDrawer(),
      body: content,
    );
  }
}
