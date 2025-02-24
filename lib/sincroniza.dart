import 'package:flutter/material.dart';
import 'package:sincroniza/configs/app_theme.dart';
import 'package:sincroniza/configs/router_config.dart';

class SincronizaApp extends StatelessWidget {
  const SincronizaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
    );
  }
}
