import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sincroniza/models/enums.dart';
import 'package:sincroniza/widgets/add_program_widget.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';

import '../../providers/configs/category_provider.dart';
import '../../widgets/custom_drawer.dart';

class NewEventScreen extends ConsumerStatefulWidget {
  const NewEventScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NewEventScreenState();
  }
}

enum DateType { startDate, endDate }

class _NewEventScreenState extends ConsumerState<NewEventScreen> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  var title;
  var startDate;
  var endDate;
  var eventDay;
  var startTime;
  var location;
  var category;
  var eventDetails;
  var conductor;
  var soloist;
  var participants;

  List<String> programList = [];

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    try {} catch (error) {
      if (error == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication failed.'),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context,
      TextEditingController dateController, DateType dateType) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        if (dateType == DateType.startDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
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
      setState(() {
        startTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  void addProgramItem(String programItem) {
    if (programItem.isNotEmpty) {
      setState(() {
        programList.add(programItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<Category, String> categories = ref.read(categoriesProvider);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Novo Evento'),
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              width: 2), // Focus effect
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 4) {
                          return 'Por favor, insira um nome válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        title = value;
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              width: 2), // Focus effect
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                      ),
                      value: category,
                      items: categories.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key.toString(),
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {}
                        return null;
                      },
                      onSaved: (value) {
                        category = value;
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: _startDateController,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        await _selectDate(
                            context, _startDateController, DateType.startDate);
                      },
                      decoration: InputDecoration(
                        labelText: 'Data inicial',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              width: 2), // Focus effect
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 4) {
                          return 'Por favor, insira um nome válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        title = value;
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: _endDateController,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        await _selectDate(
                            context, _endDateController, DateType.endDate);
                      },
                      decoration: InputDecoration(
                        labelText: 'Data final',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              width: 2), // Focus effect
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 4) {
                          return 'Por favor, insira um nome válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        title = value;
                      },
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
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              width: 2), // Focus effect
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 4) {
                          return 'Por favor, insira um nome válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        title = value;
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Local do evento',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              width: 2), // Focus effect
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 4) {
                          return 'Por favor, insira um nome válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        location = value;
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Regente',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              width: 2), // Focus effect
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 4) {
                          return 'Por favor, insira um nome válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        conductor = value;
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Solista(s)',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              width: 2), // Focus effect
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 4) {
                          return 'Por favor, insira um nome válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        soloist = value;
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
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
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
                    if (programList.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: programList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              programList[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
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
                                programList.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
                    const SizedBox(
                      height: 18,
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
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        'Cadastrar',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color:
                                  Theme.of(context).colorScheme.surfaceBright,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
