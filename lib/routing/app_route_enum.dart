enum AppRoutes {
  home,
  signIn,
  signUp,
  events,
  eventDetail,
  newEvent,
  groups,
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.home:
        return '/';
      case AppRoutes.events:
        return '/events';
      case AppRoutes.signIn:
        return '/signin';
      case AppRoutes.signUp:
        return '/signup';
      case AppRoutes.eventDetail:
        return '/event';
      case AppRoutes.newEvent:
        return '/new-event';
      case AppRoutes.groups:
        return '/groups';
    }
  }

  String get routeName {
    switch (this) {
      case AppRoutes.home:
        return '/';
      case AppRoutes.events:
        return 'events';
      case AppRoutes.signIn:
        return 'sign-in';
      case AppRoutes.signUp:
        return 'sing-up';
      case AppRoutes.eventDetail:
        return 'event-detail';
      case AppRoutes.newEvent:
        return 'new-event';
      case AppRoutes.groups:
        return 'groups';
    }
  }
}
