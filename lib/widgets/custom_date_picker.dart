import 'package:flutter/material.dart';

class CustomDatePickerResult {
  final DateTime? date;
  final bool wasCleared;
  final bool wasCancelled;

  CustomDatePickerResult._(
      {this.date, this.wasCleared = false, this.wasCancelled = false});

  factory CustomDatePickerResult.selected(DateTime date) =>
      CustomDatePickerResult._(date: date);

  factory CustomDatePickerResult.cleared() =>
      CustomDatePickerResult._(wasCleared: true);

  factory CustomDatePickerResult.cancelled() =>
      CustomDatePickerResult._(wasCancelled: true);
}

class CustomDatePicker extends StatelessWidget {
  CustomDatePicker({
    super.key,
    required this.title,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  String title;
  DateTime? initialDate;
  DateTime? firstDate;
  DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate = null;
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: CalendarDatePicker(
          initialDate: initialDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(2000),
          lastDate: lastDate ?? DateTime(2100),
          onDateChanged: (date) {
            selectedDate = date;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(CustomDatePickerResult.cleared()),
          child: Text(
            'Limpar',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(CustomDatePickerResult.cancelled()),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(
            selectedDate != null
                ? CustomDatePickerResult.selected(selectedDate!)
                : CustomDatePickerResult.cancelled(),
          ),
          child: Text('Selecionar'),
        ),
      ],
    );
  }
}
