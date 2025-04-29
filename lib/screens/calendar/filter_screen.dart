import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sincroniza/controllers/configs/category_provider.dart';
import 'package:sincroniza/controllers/configs/filters_controller.dart';

import '../../models/enums.dart';
import '../../repositories/user/firebase_auth_repository.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  var startDate;
  var endDate;
  var category;

  bool? showMyEvents = false;

  Future<DateTime?> showCustomDatePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String title = 'Escolha uma data',
  }) async {
    DateTime? selectedDate = initialDate;

    return showDialog<DateTime?>(
      context: context,
      builder: (context) {
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
              onPressed: () => Navigator.of(context).pop(null),
              child: Text(
                'Limpar',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(selectedDate),
              child: Text('Selecionar'),
            ),
          ],
        );
      },
    );
  }

  void _updateState() {
    final filtersNotifier = ref.read(filtersControllerProvider.notifier);
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    filtersNotifier.update((state) => {
          FilterType.byUserId.name:
              showMyEvents == true ? currentUser!.uid : '',
          FilterType.startDate.name: startDate ?? '',
          FilterType.endDate.name: endDate ?? '',
          FilterType.category.name: category ?? ''
        });
  }

  void closeFilterScreen() {
    Navigator.of(context).pop();
  }

  void _setMyEvents(value) {
    setState(() {
      showMyEvents = value;
    });
    _updateState();
  }

  void _setFilters(filters) {
    setState(() {
      showMyEvents = filters[FilterType.byUserId.name] != '' ? true : false;
      startDate = filters[FilterType.startDate.name] != ''
          ? filters[FilterType.startDate.name]
          : '';
      if (startDate != '') {
        _startDateController.text = DateFormat('dd/MM/yyyy').format(startDate);
      }
      endDate = filters[FilterType.endDate.name] != ''
          ? filters[FilterType.endDate.name]
          : '';
      if (endDate != '') {
        _endDateController.text = DateFormat('dd/MM/yyyy').format(endDate);
      }
      category = filters[FilterType.category.name] != ''
          ? filters[FilterType.category.name]
          : null;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final filters = ref.watch(filtersControllerProvider);
    _setFilters(filters);
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 25),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Filtros",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                  )
                ],
              ),
            ),
            const Divider(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: showMyEvents,
                  onChanged: (value) => _setMyEvents(value),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    // Rounded corners
                  ),
                ),
                Text(
                  "Mostrar apenas os meus eventos",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Intervalo de datas",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  )
                ],
              ),
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _startDateController,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime? selected =
                          await showCustomDatePicker(context: context);
                      setState(() {
                        startDate = selected;
                        _updateState();
                        if (selected != null) {
                          _startDateController.text =
                              DateFormat('dd/MM/yyyy').format(selected);
                        } else {
                          _startDateController.text = '';
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Data Inicial',
                      fillColor: Theme.of(context).colorScheme.onSecondary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        // Rounded corners
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 2), // Focus effect
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    onSaved: (value) {
                      startDate = value;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _endDateController,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime? selected = await showCustomDatePicker(
                        context: context,
                      );
                      setState(() {
                        endDate = selected;
                        _updateState();
                        if (selected != null) {
                          _endDateController.text =
                              DateFormat('dd/MM/yyyy').format(selected);
                        } else {
                          _endDateController.text = '';
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Data final',
                      fillColor: Theme.of(context).colorScheme.onSecondary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        // Rounded corners
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 2), // Focus effect
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    onSaved: (value) {
                      endDate = value;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Categoria",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                )
              ],
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  fillColor: Theme.of(context).colorScheme.onSecondary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSecondary,
                        width: 2), // Focus effect
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                ),
                value: category,
                items: categories.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    category = newValue;
                  });
                  _updateState();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {}
                  return null;
                },
                onSaved: (value) {
                  category = value;
                },
              ),
            ),
            ElevatedButton(
              onPressed: closeFilterScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Aplicar',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surfaceBright,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
