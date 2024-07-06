import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'utils/simple_bloc_observer.dart';
Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    Bloc.observer = SimpleBlocObserver();
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  }, (error, stack) {});
}
