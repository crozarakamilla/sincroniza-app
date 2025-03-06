import 'package:flutter/material.dart';

import '../models/app_user.dart';

class UsersInGroup extends StatefulWidget {
  UsersInGroup({super.key, required this.users, required this.onUsertap});

  final List<AppUser> users;
  final Function onUsertap;
  List<String> selectedUsers = [];

  @override
  State<UsersInGroup> createState() => _UsersInGroupState();
}

class _UsersInGroupState extends State<UsersInGroup> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (ctx, index) => InkWell(
          onTap: () {
            setState(() {
              if (widget.selectedUsers.contains(widget.users[index].uid)) {
                widget.selectedUsers.remove(widget.users[index].uid);
              } else {
                widget.selectedUsers.add(widget.users[index].uid);
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
                visible: widget.selectedUsers.contains(widget.users[index].uid),
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
