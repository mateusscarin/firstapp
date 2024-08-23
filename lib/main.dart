import 'package:firstapp/imc.dart';
import 'package:firstapp/salary.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyTabBar());
}

class MyTabBar extends StatelessWidget {
  const MyTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.calculate)),
                Tab(icon: Icon(Icons.monetization_on)),
              ],
            ),
            title: const Text('My App'),
          ),
          body: const TabBarView(
            children: [Imc(), Salary()],
          ),
        ),
      ),
    );
  }
}
