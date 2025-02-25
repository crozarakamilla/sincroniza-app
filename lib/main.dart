import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sincroniza/sincroniza.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await FirebaseAppCheck.instance.activate(
  // webProvider: ReCaptchaV3Provider(secrets['recaptcha']!),
  //);
  initializeDateFormatting('pt_BR', null).then(
    (_) => runApp(
      const ProviderScope(
        child: SincronizaApp(),
      ),
    ),
  );
}
