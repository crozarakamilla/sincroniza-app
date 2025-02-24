import 'package:flutter/material.dart';

class EventDetailsList extends StatefulWidget {
  const EventDetailsList(
      {super.key, required this.details, this.initialItemCount = 3});

  final List<String> details;
  final int initialItemCount;

  @override
  State<EventDetailsList> createState() => _EventDetailsListState();
}

class _EventDetailsListState extends State<EventDetailsList> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final visibleItems = _isExpanded
        ? widget.details
        : widget.details.take(widget.initialItemCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...visibleItems.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                const Text('- '),
                Expanded(
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        if (widget.details.length > widget.initialItemCount)
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Text(
              _isExpanded ? "Ver menos" : "Ver mais...",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
      ],
    );
  }
}
