import 'package:background_sample/view/custom/lifecycle_manager.dart';
import 'package:background_sample/view/record_list_view.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BackGroundSample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LifecycleManager(RecordListView()));
  }
}
