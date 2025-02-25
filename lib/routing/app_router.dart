import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/routing/refresh_listenable.dart';
import 'package:sincroniza/screens/events/events_screen.dart';
import 'package:sincroniza/screens/users/auth_screen.dart';
import 'package:sincroniza/screens/users/sign_up_screen.dart';

import '../repositories/firebase_auth_repository.dart';
import 'app_route_enum.dart';

part 'app_router.g.dart';

final _key = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) {
  final auth = ref.watch(authRepositoryProvider);
  return GoRouter(
    navigatorKey: _key,
    initialLocation: AppRoutes.events.path,
    routes: [
      GoRoute(
        path: AppRoutes.events.path,
        name: AppRoutes.events.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: EventsScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.signIn.path,
        name: AppRoutes.signIn.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: AuthScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.signUp.path,
        name: AppRoutes.signUp.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: SignUpScreen(),
        ),
      ),
    ],
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges()),
    redirect: (context, state) async {
      final bool isLoggedIn = auth.currentUser != null;
      final bool isLoggingIn = state.matchedLocation == AppRoutes.signIn.path ||
          state.matchedLocation == AppRoutes.signUp.path;

      // should redirect the user to the sign in page if they are not logged in
      if (!isLoggedIn && !isLoggingIn) {
        return AppRoutes.signIn.path;
      }

      // should redirect the user after they have logged in
      if (isLoggedIn && isLoggingIn) {
        return AppRoutes.events.path;
      }
      return null;
    },
  );
}
