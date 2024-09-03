import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'Provider/PostProvider.dart';
import 'View/Screen/Home_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostProvider(),
      child: MaterialApp(
        title: 'Practical Task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
