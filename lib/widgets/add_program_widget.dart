import 'package:flutter/material.dart';

class AddProgramWidget extends StatelessWidget {
  const AddProgramWidget({super.key, required this.addItem});

  final Function addItem;

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    String? programItem;

    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 10, right: 23, bottom: 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      // Rounded corners
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.surfaceContainer),
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
                          color:
                              Theme.of(context).colorScheme.surfaceContainer),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                  ),
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  onChanged: (value) {
                    programItem = value;
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  if (programItem != null) {
                    addItem(programItem);
                    textController.clear();
                  }
                },
                child: Icon(
                  Icons.add_circle_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
