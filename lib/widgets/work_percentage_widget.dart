import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sincroniza/controllers/work_engine/user_percentage_of_work_controller.dart';
import 'package:sincroniza/models/enums.dart';

class WorkPercentageWidget extends ConsumerWidget {
  const WorkPercentageWidget({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPercentages =
        ref.watch(userPercentageOfWorkControllerProvider(userId));

    return userPercentages.when(data: (Map<String, double> percentages) {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircularPercentIndicator(
              radius: 25.0,
              lineWidth: 5.0,
              animation: true,
              animationDuration: 1200,
              percent: 0.7,
              center: Text(
                "${percentages[CategoryEnum.oficial.name.toString()]}%",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                    ),
              ),
              footer: Text(
                "Oficiais",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                      fontSize: 8.0,
                    ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              progressColor: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(
              width: 8,
            ),
            CircularPercentIndicator(
              radius: 25.0,
              lineWidth: 5.0,
              animation: true,
              animationDuration: 1200,
              percent: 0.4,
              center: Text(
                "${percentages[CategoryEnum.extraordinario.name.toString()]}%",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                    ),
              ),
              footer: Text(
                "Extraordinários",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 8.0,
                    ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              progressColor: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
        body: const Padding(
          padding: EdgeInsets.all(18),
          child: Center(
            child: Column(),
          ),
        ),
      );
    }, loading: () {
      return CircularProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
      );
    });
  }
}
