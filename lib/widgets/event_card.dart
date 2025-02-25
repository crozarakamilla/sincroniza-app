import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/models/enums.dart';
import 'package:sincroniza/models/event.dart';

import '../controllers/configs/category_provider.dart';
import '../models/category.dart';

class EventCard extends ConsumerWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.onSelectEvent,
  });

  final Event event;
  final void Function(Event event) onSelectEvent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<CategoryEnum, Category> categoriesValues =
        ref.read(categoriesProvider);

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectEvent(event);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surfaceTint,
                      fontWeight: FontWeight.w900,
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
                    color: Theme.of(context).colorScheme.primary,
                    weight: 10.0,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    categoriesValues[event.category == 'oficial'
                            ? CategoryEnum.oficial
                            : CategoryEnum.extraordinario]!
                        .name,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.surfaceTint,
                          fontWeight: FontWeight.w900,
                        ),
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
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(event.formattedEventDay)
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.pin_drop,
                    size: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(event.location)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
