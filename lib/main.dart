import 'package:flutter/material.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alexis Sones Art',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.blue.shade600,
      ),
      home: HomePage(),
    );
  }
}
