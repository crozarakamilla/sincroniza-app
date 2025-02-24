import 'package:flutter/material.dart';
import 'package:sincroniza/models/enums.dart';
import 'package:sincroniza/models/event.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.onSelectEvent,
  });

  final Event event;
  final void Function(Event event) onSelectEvent;

  @override
  Widget build(BuildContext context) {
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
                    event.category.name == 'oficial'
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
                    categoriesValues[event.category]!,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.surfaceTint,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
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
