import 'dart:convert';

import 'package:bp_display/pages/DisplayPage/display.page.dart';
import 'package:bp_display/services/OrderService/Order.Service.dart';
import 'package:bp_display/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

import 'pages/OrderHistoryPage/OrderHistory.page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: BPTheme.themeData,
      initialRoute: '/',
      routes: {
        '/':(context) => const DisplayPage(),
        '/orderHistory':(context) => const OrderHistoryPage(),
      }
    );
  }
}