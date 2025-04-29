import 'package:flutter/material.dart';

import '../models/app_user.dart';

class AddUsersToEvent extends StatefulWidget {
  AddUsersToEvent(
      {super.key,
      required this.users,
      required this.onUsertap,
      required this.usersInEvent});

  final List<AppUser> users;
  final Function onUsertap;
  final List<String> usersInEvent;

  @override
  State<AddUsersToEvent> createState() => _AddUsersToEventState();
}

class _AddUsersToEventState extends State<AddUsersToEvent> {
  List<String> selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (ctx, index) => InkWell(
          onTap: () {
            setState(() {
              if (selectedUsers.contains(widget.users[index].uid)) {
                selectedUsers.remove(widget.users[index].uid);
              } else {
                selectedUsers.add(widget.users[index].uid);
              }
            });
            widget.onUsertap(widget.users[index].uid);
          },
          child: Card.outlined(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryFixed,
                radius: 20,
                backgroundImage: widget.users[index].photoUrl != ""
                    ? NetworkImage(widget.users[index].photoUrl!)
                    : AssetImage('assets/images/user.png'),
              ),
              title: Text(
                widget.users[index].name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              trailing: Visibility(
                visible: widget.usersInEvent.contains(widget.users[index].uid),
                child: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
