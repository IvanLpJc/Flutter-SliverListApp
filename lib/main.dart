import 'package:flutter/material.dart';
import 'package:sliver_list_app/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        SliverListPage.route: (_) => const SliverListPage(),
      },
      initialRoute: SliverListPage.route,
    );
  }
}
