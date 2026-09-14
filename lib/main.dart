import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/services/bloc_observer.dart';
import 'core/services/services_locator.dart';
import 'core/src/src.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initAppModule();
  Bloc.observer = BlocObserverReader();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   await Supabase.initialize(
    url: 'https://cvjjkzcisgbwgxvyiikx.supabase.co',
    anonKey: 'sb_publishable_EpubB_aTdpc4UY7EjRvTEg_ujLCSIJd',
  );
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
          MyApp(),
  //)
  )
  ;}

