import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sincroniza/screens/calendar_screen.dart';
import 'package:sincroniza/screens/events/events_screen.dart';
import 'package:sincroniza/screens/events/new_event_screen.dart';
import 'package:sincroniza/screens/users/auth_screen.dart';
import 'package:sincroniza/screens/users/profile_screen.dart';
import 'package:sincroniza/screens/users/sign_up_screen.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: 'auth',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const AuthScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'sign-up',
            path: 'sign-up',
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpScreen();
            },
          ),
          GoRoute(
            name: 'events',
            path: 'events',
            builder: (BuildContext context, GoRouterState state) {
              return const EventsScreen();
            },
          ),
          GoRoute(
            name: 'new-event',
            path: 'new-event',
            builder: (BuildContext context, GoRouterState state) {
              return const NewEventScreen();
            },
          ),
          GoRoute(
            name: 'calendar',
            path: 'calendar',
            builder: (BuildContext context, GoRouterState state) {
              return const CalendarScreen();
            },
          ),
          GoRoute(
            name: 'profile',
            path: 'profile',
            builder: (BuildContext context, GoRouterState state) {
              return const ProfileScreen();
            },
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
