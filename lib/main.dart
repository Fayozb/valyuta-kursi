import 'package:flutter/material.dart';

import 'app.dart';
import 'dependensiy_meneger.dart';

Future<void> main() async {
  await setUpDependencies();
  runApp(const MyApp());
}
