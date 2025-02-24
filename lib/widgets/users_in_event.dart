import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../models/user.dart';

class UsersInEvent extends StatelessWidget {
  const UsersInEvent({super.key, required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              spacing: 4,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryFixed,
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Test',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircularPercentIndicator(
                        radius: 25.0,
                        lineWidth: 5.0,
                        animation: true,
                        percent: 0.7,
                        center: Text(
                          "70.0%",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                  ),
                        ),
                        footer: Text(
                          "Oficiais",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8.0,
                                  ),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CircularPercentIndicator(
                        radius: 25.0,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 5.0,
                        percent: 0.4,
                        center: Text(
                          "1",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.0),
                        ),
                        footer: Text(
                          "Extraordinários",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 8.0,
                              ),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        progressColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
