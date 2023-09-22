import 'package:flutter/material.dart';
import 'package:hanbit_directory/src/screens/directory_screen.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => Storybook(stories: [
        Story(
            name: "Screens/DirectoryScreen",
            builder: (context) => const DirectoryScreen())
      ]);
}
