import 'dart:convert';

import 'package:bp_display/pages/DisplayPage/display.page.dart';
import 'package:bp_display/services/OrderService/Order.Service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

import 'pages/OrderHistoryPage/OrderHistory.page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson);
  runApp(MyApp(theme: theme!));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  const MyApp({super.key, required this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      initialRoute: '/',
      routes: {
        '/':(context) => const DisplayPage(),
        '/orderHistory':(context) => const OrderHistoryPage(),
      }
    );
  }
}