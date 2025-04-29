import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sincroniza/controllers/groups/group_controller.dart';
import 'package:sincroniza/models/group.dart';
import 'package:sincroniza/routing/app_route_enum.dart';
import 'package:sincroniza/widgets/custom_app_bar.dart';
import 'package:uuid/uuid.dart';

import '../../repositories/user/firebase_auth_repository.dart';

class NewGroupScreen extends ConsumerStatefulWidget {
  const NewGroupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NewGroupScreenState();
  }
}

enum DateType { startDate, endDate, groupDay }

class _NewGroupScreenState extends ConsumerState<NewGroupScreen> {
  List<String> usersList = [];
  bool instrumentsCheck = false;
  final _form = GlobalKey<FormState>();

  BuildContext? _progressIndicatorContext;
  var uuid = const Uuid();

  String? name;
  var events;

  Future<void> _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    FocusScope.of(context).unfocus();

    Group newGroup = Group(
      id: uuid.v4(),
      name: name ?? '',
      users: usersList,
      groupAdmins: [ref.read(authRepositoryProvider).currentUser!.uid],
      events: events,
      instruments: instrumentsCheck,
    );
    final groupController = ref.read(groupControllerProvider.notifier);
    await groupController.postGroup(newGroup);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Naipe adicionado!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    usersList = [];
    instrumentsCheck = false;
  }

  @override
  void dispose() {
    if (_progressIndicatorContext != null &&
        _progressIndicatorContext!.mounted) {
      context.goNamed(AppRoutes.groups.name);
      _progressIndicatorContext = null;
    }
    super.dispose();
  }

  void addGroupAdmin() {
    var admin = ref.read(authRepositoryProvider).currentUser!.uid;
    if (!usersList.contains(admin)) {
      usersList.add(admin);
    }
  }

  @override
  Widget build(BuildContext context) {
    addGroupAdmin();
    ref.listen(groupControllerProvider, (prev, state) async {
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
        title: 'Novo Naipe',
        showDefaultActions: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
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
                        fillColor: Theme.of(context).colorScheme.onSecondary,
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
                              color: Theme.of(context).colorScheme.onSecondary,
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
                        name = value;
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SwitchListTile(
                      value: instrumentsCheck,
                      onChanged: (isChecked) {
                        setState(() {
                          instrumentsCheck = isChecked;
                        });
                      },
                      title: Text(
                        'Incluir instrumentação',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      subtitle: Text(
                        'Incluir instrumentação quando adicionar membros a eventos do naipe.',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      activeColor: Theme.of(context).colorScheme.secondary,
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
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                      child: Text(
                        'Adicionar',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
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
