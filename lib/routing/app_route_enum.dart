enum AppRoutes {
  signIn,
  signUp,
  events,
  eventDetail,
  newEvent,
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.events:
        return '/';
      case AppRoutes.signIn:
        return '/signin';
      case AppRoutes.signUp:
        return '/signup';
      case AppRoutes.eventDetail:
        return '/event';
      case AppRoutes.newEvent:
        return '/new-event';
    }
  }

  String get routeName {
    switch (this) {
      case AppRoutes.events:
        return 'Eventos';
      case AppRoutes.signIn:
        return '/Entrar';
      case AppRoutes.signUp:
        return '/Cadastrar';
      case AppRoutes.eventDetail:
        return '/Evento';
      case AppRoutes.newEvent:
        return '/Novo Evento';
    }
  }
}
