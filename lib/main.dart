import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'commons/globals.dart';
import 'modules/student/list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BijuliExpress',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'RoboCondensed'),
        initialRoute: '/entry',
        routes: <String, WidgetBuilder>{
          '/entry': (BuildContext context) => StudentList()
        });
  }
}
