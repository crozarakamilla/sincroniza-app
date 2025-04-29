import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/controllers/events/event_controller.dart';
import 'package:sincroniza/repositories/events/meeting_repository.dart';
import 'package:sincroniza/widgets/event_detail_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/event.dart';
import '../../models/meeting.dart';
import '../../models/meeting_data_source.dart';
import '../../widgets/loading_widget.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final events = ref.watch(meetingListProvider);

    return events.when(data: (List<Meeting> meetings) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
        body: Container(
          padding: const EdgeInsets.all(8),
          child: SfCalendar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            todayHighlightColor: Theme.of(context).colorScheme.secondary,
            headerStyle: const CalendarHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            viewHeaderStyle: const ViewHeaderStyle(
              dayTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            timeZone: 'America/Sao_Paulo',
            showNavigationArrow: true,
            view: CalendarView.month,
            onTap: (data) async {
              if (data.appointments!.isNotEmpty) {
                Event? event = await ref
                    .read(eventControllerProvider.notifier)
                    .fetchEventById(data.appointments!.first.eventId);
                if (event != null) {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: false,
                      useSafeArea: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      builder: (BuildContext context) {
                        return EventDetailWidget(event: event);
                      });
                }
              }
            },
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
            dataSource: MeetingDataSource(meetings),
            timeSlotViewSettings:
                TimeSlotViewSettings(startHour: 9, endHour: 18),
          ),
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ocorreu um erro ao carregar os eventos!',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 32,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Tente novamente mais tarde.',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }, loading: () {
      return const LoadingWidget();
    });
    return Container();
  }
}
