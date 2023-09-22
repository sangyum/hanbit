import 'package:flutter/material.dart';
import 'package:hanbit_directory/src/models/contact.dart';
import 'package:hanbit_directory/src/screens/directory_screen.dart';
import 'package:hanbit_directory/src/widgets/contact_tile.dart';
import 'package:hanbit_directory/src/widgets/contact_tile_list.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const koreanName = "염상용";
    const englishName = "Sang Yum";
    const phoneNumber = "8585551212";
    const email = "sangyum@gmail.com";
    var birthDate = DateTime.parse('2022-01-01');
    const avatar =
        "https://avatars.planningcenteronline.com/uploads/person/88055421-1612583333/avatar.1.jpg";

    final contact =
        Contact(koreanName, englishName, phoneNumber, email, birthDate, avatar);

    final contacts = Iterable.generate(100).map((i) => contact).toList();

    var stories = [
      Story(
          name: "Screens/DirectoryScreen",
          builder: (context) => const DirectoryScreen()),
      Story(
        name: 'Widgets/ContactTile',
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Contact Tile')),
          body: Center(
            child: ContactTile(contact),
          ),
        ),
      ),
      Story(
        name: 'Widgets/ContactTileList',
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Contact Tile')),
          body: Center(
            child: ContactTileList(contacts),
          ),
        ),
      )
    ];

    return Storybook(stories: stories);
  }
}
