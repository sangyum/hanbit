import 'package:flutter/material.dart';

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Directory')),
        body: const Row(children: [
          Text('hello'),
          Text('World'),
        ]));
  }
}
