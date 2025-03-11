import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';

import '../../controllers/configs/category_provider.dart';
import '../../models/category.dart';
import '../../models/enums.dart';
import '../../models/event.dart';
import '../../widgets/add_program_widget.dart';

class EditEventScreen extends ConsumerStatefulWidget {
  EditEventScreen({super.key, required this.event});

  Event event;

  @override
  ConsumerState<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends ConsumerState<EditEventScreen> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _eventDayController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  var eventDay;
  var startTime;
  var category;

  Future<void> _selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        widget.event.eventDay = DateFormat('dd/MM/yyyy').format(picked);
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      var startDate = DateFormat('dd/MM/yyyy').parse(_eventDayController.text);
      var time = DateFormat('HH:mm').parse(picked.format(context));
      DateTime startDateTime = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        time.hour,
        time.minute,
      );
      setState(() {
        widget.event.startTime = DateFormat('HH:mm').format(startDateTime);
        _timeController.text = picked.format(context);
      });
    }
  }

  void addProgramItem(String programItem) {
    if (programItem.isNotEmpty) {
      setState(() {
        widget.event.eventDetails!.add(programItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _eventDayController.text = widget.event.eventDay!;
    _timeController.text = widget.event.startTime!;

    final Map<CategoryEnum, Category> categories = ref.read(categoriesProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
      appBar: CustomAppBar(
          title: 'Editar - ${widget.event.title}', showDefaultActions: false),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: widget.event.title,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  // Rounded corners
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      width: 2), // Focus effect
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              keyboardType: TextInputType.text,
              autocorrect: false,
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty || value.length < 4) {
                  return 'Por favor, insira um nome válido.';
                }
                return null;
              },
              onChanged: (value) {
                widget.event.title = value;
              },
            ),
            const SizedBox(
              height: 18,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Categoria',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      width: 2), // Focus effect
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              ),
              value: widget.event.category,
              items: categories.entries.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key.name,
                  child: Text(entry.value.name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  category = newValue;
                });
                widget.event.category = newValue;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {}
                return null;
              },
            ),
            const SizedBox(
              height: 18,
            ),
            TextFormField(
              controller: _eventDayController,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                await _selectDate(context, _eventDayController);
              },
              decoration: InputDecoration(
                labelText: 'Dia do evento',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  // Rounded corners
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      width: 2), // Focus effect
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              keyboardType: TextInputType.text,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
            ),
            const SizedBox(
              height: 18,
            ),
            TextFormField(
              controller: _timeController,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                await _selectTime(context);
              },
              decoration: InputDecoration(
                labelText: 'Horário do evento',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  // Rounded corners
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      width: 2), // Focus effect
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              keyboardType: TextInputType.text,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.trim().isEmpty || value.length < 3) {
                  return 'Por favor, insira um horário válido.';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 18,
            ),
            TextFormField(
              initialValue: widget.event.rehearsalsQuantity,
              decoration: InputDecoration(
                labelText: 'Quantidade de ensaios',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  // Rounded corners
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      width: 2), // Focus effect
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              keyboardType: TextInputType.number,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              enableSuggestions: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty || value.length < 4) {
                  return 'Por favor, insira um nome válido.';
                }
                return null;
              },
              onChanged: (value) {
                widget.event.rehearsalsQuantity = value;
              },
            ),
            const SizedBox(
              height: 18,
            ),
            TextFormField(
              initialValue: widget.event.location,
              decoration: InputDecoration(
                labelText: 'Local do evento',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  // Rounded corners
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      width: 2), // Focus effect
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              keyboardType: TextInputType.text,
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.trim().isEmpty || value.length < 4) {
                  return 'Por favor, insira um local válido.';
                }
                return null;
              },
              onChanged: (value) {
                widget.event.location = value;
              },
            ),
            const SizedBox(
              height: 18,
            ),
            TextFormField(
              initialValue: widget.event.conductor,
              decoration: InputDecoration(
                labelText: 'Regente',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  // Rounded corners
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      width: 2), // Focus effect
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              keyboardType: TextInputType.text,
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                widget.event.conductor = value;
              },
            ),
            const SizedBox(
              height: 18,
            ),
            TextFormField(
              initialValue: widget.event.soloist,
              decoration: InputDecoration(
                labelText: 'Solista(s)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  // Rounded corners
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      width: 2), // Focus effect
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              keyboardType: TextInputType.text,
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) {
                widget.event.soloist = value;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Programação",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            if (widget.event.eventDetails!.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.event.eventDetails!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      widget.event.eventDetails![index],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.remove_circle,
                      color: Theme.of(context).colorScheme.error,
                      size: 30,
                    ),
                    onTap: () {
                      setState(() {
                        widget.event.eventDetails!.removeAt(index);
                      });
                    },
                  );
                },
              ),
            const SizedBox(
              height: 5,
            ),
            AddProgramWidget(
              addItem: addProgramItem,
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, widget.event);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Salvar',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surfaceBright,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
