import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/models/enums.dart';
import 'package:sincroniza/models/event.dart';

import '../controllers/configs/category_provider.dart';
import '../models/category.dart';

class EventCard extends ConsumerWidget {
  EventCard(
      {super.key,
      required this.event,
      required this.onEditEvent,
      required this.onSelectEvent,
      this.onAddParticipants,
      required this.onDeleteEvent});

  final Event event;
  final void Function(Event event) onEditEvent;
  final void Function(Event event) onSelectEvent;
  void Function(Event event)? onAddParticipants;
  final void Function(Event event) onDeleteEvent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, Category> categoriesValues = ref.read(categoriesProvider);

    return InkWell(
      onTap: () {
        onSelectEvent(event);
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.0,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title!,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surfaceTint,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
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
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(event.eventDay!)
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
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(event.location!)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).colorScheme.secondary,
                      thickness: 0.7,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      onAddParticipants!(event);
                    },
                    style: IconButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryFixed),
                    icon: Icon(
                      Icons.group_add,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      onEditEvent(event);
                    },
                    style: IconButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryFixed),
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      onDeleteEvent(event);
                    },
                    style: IconButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryFixed),
                    icon: Icon(
                      Icons.delete_forever,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
