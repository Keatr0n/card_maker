import 'package:flutter/material.dart';
import 'package:card_maker/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Make a card',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
      ),
      home: const Material(child: HomeScreen()),
    );
  }
}
