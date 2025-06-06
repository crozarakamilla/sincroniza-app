import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sincroniza/configs/app_theme.dart';
import 'package:sincroniza/routing/app_router.dart';

class SincronizaApp extends ConsumerWidget {
  const SincronizaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(routerProvider);

    return MaterialApp.router(
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
    );
  }
}
