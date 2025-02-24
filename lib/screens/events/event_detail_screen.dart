import 'package:flutter/material.dart';
import 'package:sincroniza/models/event.dart';
import 'package:sincroniza/models/user.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';
import 'package:sincroniza/widgets/custom_drawer.dart';
import 'package:sincroniza/widgets/event_details_list.dart';
import 'package:sincroniza/widgets/users_in_event.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final List<User> users = [];

    return Scaffold(
      appBar: CustomAppBar(title: event.title),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (event.eventDetails != null)
              EventDetailsList(details: event.eventDetails!),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Escalação',
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
  }
}
