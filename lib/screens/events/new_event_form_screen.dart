import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sincroniza/controllers/events/event_controller.dart';
import 'package:sincroniza/controllers/groups/user_groups_controller.dart';
import 'package:sincroniza/models/category.dart';
import 'package:sincroniza/models/enums.dart';
import 'package:sincroniza/models/event.dart';
import 'package:sincroniza/routing/app_route_enum.dart';
import 'package:sincroniza/widgets/add_program_widget.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';
import 'package:uuid/uuid.dart';

import '../../controllers/configs/category_provider.dart';
import '../../models/group.dart';
import '../../repositories/user/firebase_auth_repository.dart';

class NewEventFormScreen extends ConsumerStatefulWidget {
  const NewEventFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NewEventScreenState();
  }
}

enum DateType { startDate, endDate, eventDay }

class _NewEventScreenState extends ConsumerState<NewEventFormScreen> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _eventDayController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  BuildContext? _progressIndicatorContext;
  var uuid = const Uuid();

  List<Group> userGroups = [];
  String? selectedGroup;

  var title;
  var eventDay;
  var startDate;
  var endDate;
  var startTime;
  var rehearsals;
  var location;
  var category;
  var eventDetails;
  var conductor;
  var soloist;
  var participants;

  List<String> programList = [];

  Future<void> _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    FocusScope.of(context).unfocus();

    startDate = DateFormat('dd/MM/yyyy').parse(_startDateController.text);
    endDate = DateFormat('dd/MM/yyyy').parse(_endDateController.text);
    _eventDayController.text;
    startTime = DateFormat('HH:mm').parse(startTime);

    DateTime startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );

    Event newEvent = Event(
      id: uuid.v4(),
      title: title,
      eventDay: eventDay,
      startTime: startTime,
      rehearsalsQuantity: rehearsals,
      location: location,
      conductor: conductor,
      soloist: soloist,
      category: category,
      groupId: userGroups.length == 1 ? userGroups.first.id : selectedGroup!,
      eventDetails: programList,
    );
    final eventController = ref.read(eventControllerProvider.notifier);
    await eventController.postEvent(newEvent);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Evento adicionado!'),
        ),
      );
      Navigator.of(context).pop();
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
        }
        if (dateType == DateType.endDate) {
          endDate = picked;
        }
        if (dateType == DateType.eventDay) {
          eventDay = picked;
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
  void dispose() {
    _timeController.dispose();
    _endDateController.dispose();
    _eventDayController.dispose();
    _startDateController.dispose();

    if (_progressIndicatorContext != null &&
        _progressIndicatorContext!.mounted) {
      context.goNamed(AppRoutes.events.name);
      _progressIndicatorContext = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<CategoryEnum, Category> categories = ref.read(categoriesProvider);
    final groups = ref.watch(userGroupsControllerProvider(
        ref.read(authRepositoryProvider).currentUser!.uid));

    groups.whenData((data) => userGroups = data);

    ref.listen(eventControllerProvider, (prev, state) async {
      if (state.isLoading) {
        await showDialog(
            context: context,
            builder: (ctx) {
              _progressIndicatorContext = ctx;
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
        return;
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (_progressIndicatorContext != null &&
            _progressIndicatorContext!.mounted) {
          Navigator.of(_progressIndicatorContext!).pop();
          _progressIndicatorContext = null;
        }
      });

      if (state.hasError) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Error: ${state.error}'),
          ),
        );
      }
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Novo Evento',
        showDefaultActions: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: userGroups.length == 1,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Grupo: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                            ),
                            Text(
                              userGroups.length == 1
                                  ? userGroups.first.name
                                  : '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: userGroups.length > 1,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Grupo',
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
                              vertical: 15, horizontal: 5),
                        ),
                        value: selectedGroup,
                        items: userGroups.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.id,
                            child: Text(entry.name),
                          );
                        }).toList(),
                        onChanged: (String? newGroup) {
                          setState(() {
                            selectedGroup = newGroup;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {}
                          return null;
                        },
                        onSaved: (value) {
                          selectedGroup = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          // Rounded corners
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
                      textCapitalization: TextCapitalization.sentences,
                      enableSuggestions: true,
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
                            vertical: 15, horizontal: 5),
                      ),
                      value: category,
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
                      decoration: InputDecoration(
                        labelText: 'Quantidade de ensaios',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          // Rounded corners
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
                      textCapitalization: TextCapitalization.sentences,
                      enableSuggestions: true,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 4) {
                          return 'Por favor, insira um nome válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        rehearsals = value;
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: _eventDayController,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        await _selectDate(
                            context, _eventDayController, DateType.eventDay);
                      },
                      decoration: InputDecoration(
                        labelText: 'Dia do evento',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          // Rounded corners
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
                      onSaved: (value) {
                        eventDay = value;
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
                          borderRadius: BorderRadius.circular(10),
                          // Rounded corners
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
                            value.length < 3) {
                          return 'Por favor, insira um horário válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        startTime = value;
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Local do evento',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          // Rounded corners
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
                      autocorrect: true,
                      enableSuggestions: true,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 4) {
                          return 'Por favor, insira um local válido.';
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
                          borderRadius: BorderRadius.circular(10),
                          // Rounded corners
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
                      autocorrect: true,
                      enableSuggestions: true,
                      textCapitalization: TextCapitalization.sentences,
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
                          borderRadius: BorderRadius.circular(10),
                          // Rounded corners
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
                      autocorrect: true,
                      enableSuggestions: true,
                      textCapitalization: TextCapitalization.words,
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
                        'Adicionar',
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
                    const SizedBox(
                      height: 35,
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
