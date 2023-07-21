import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Repositories'),
        centerTitle: true,
      ),
      body: const Center(
          child: Text(
        'Dev Task',
        style: TextStyle(fontSize: 22),
      )),
    );
  }
}
