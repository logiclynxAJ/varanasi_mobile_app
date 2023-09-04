import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:varanasi_mobile_app/features/home/data/models/adapters.dart';

import 'app.dart';
import 'models/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  registerCommonTypeAdapters();
  registerHomePageTypeAdapters();
  runApp(const Varanasi());
}
