import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/controllers/configs/category_provider.dart';

import '../models/enums.dart';
import '../models/event.dart';
import 'event_details_list.dart';

class EventDetailWidget extends ConsumerWidget {
  EventDetailWidget({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesValues = ref.read(categoriesProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title!,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.surfaceTint,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(
                  event.category == 'oficial'
                      ? Icons.check
                      : Icons.outbond_outlined,
                  size: 15,
                  color: Theme.of(context).colorScheme.secondary,
                  weight: 10.0,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  categoriesValues[event.category == 'oficial'
                          ? CategoryEnum.oficial.name
                          : CategoryEnum.extraordinario.name]!
                      .name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.surfaceTint,
                      fontWeight: FontWeight.w900,
                      fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(
                  Icons.date_range,
                  size: 15,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  event.eventDay!,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.surfaceTint,
                      fontWeight: FontWeight.w900,
                      fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            EventDetailsList(details: event.eventDetails!)
          ],
        ),
      ),
    );
  }
}
