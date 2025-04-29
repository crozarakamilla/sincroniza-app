import 'package:flutter/material.dart';
import 'package:sincroniza/widgets/work_percentage_widget.dart';

import '../models/app_user.dart';

class UsersInEvent extends StatelessWidget {
  const UsersInEvent({super.key, required this.users});

  final List<AppUser> users;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryFixed,
                      radius: 20,
                      backgroundImage: users[index].photoUrl != ""
                          ? NetworkImage(users[index].photoUrl!)
                          : AssetImage('assets/images/user.png'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      users[index].name,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    WorkPercentageWidget(userId: users[index].uid),
                  ],
                ),
                Text(
                  index + 1 > 2
                      ? "2ª estante"
                      : index + 1 > 4
                          ? "3ª estante"
                          : index + 1 > 6
                              ? "4ª estante"
                              : index + 1 > 8
                                  ? "5ª estante"
                                  : index + 1 > 10
                                      ? "6ª estante"
                                      : index + 1 > 12
                                          ? "7ª estante"
                                          : index + 1 > 14
                                              ? "8ª estante"
                                              : index + 1 > 16
                                                  ? "9ª estante"
                                                  : "1ª estante",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
