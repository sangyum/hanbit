import 'package:flutter/material.dart';
import 'package:hanbit_directory/src/models/contact.dart';
import 'package:hanbit_directory/src/proxy/planningCenter/people_response.dart';
import 'package:hanbit_directory/src/screens/directory/screen.dart';
import 'package:hanbit_directory/src/storybook/mock_search_people.dart';
import 'package:hanbit_directory/src/widgets/contact_tile.dart';
import 'package:hanbit_directory/src/widgets/contact_tile_list.dart';
import 'package:hanbit_directory/src/widgets/phone_number_widget.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const koreanName = "염상용";
    const englishName = "Sang Yum";
    var birthDate = DateTime.parse('2022-01-01');
    const avatar =
        "https://avatars.planningcenteronline.com/uploads/person/88055421-1612583333/avatar.1.jpg";
    var phoneNumbers = List.of([
      PhoneNumber(
          '1234', 'PhoneNumber', true, '+18585551212', '858-555-1212', 'home'),
      PhoneNumber(
          '1234', 'PhoneNumber', false, '+18583668454', '858-633-8454', 'work')
    ]);
    var emails = List.of([
      Email('1234', 'Email', true, 'foo@bar.com', 'home'),
      Email('3456', 'Email', false, 'foo@baz.com', 'work')
    ]);

    final contact = Contact(
        koreanName, englishName, phoneNumbers, emails, birthDate, avatar);

    final contacts = Iterable.generate(100).map((i) => contact).toList();

    var stories = [
      Story(
          name: "Screens/DirectoryScreen",
          builder: (context) => DirectoryScreen(MockSearchPeople())),
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
      ),
      Story(
          name: 'Widgets/PhoneNumber',
          builder: (context) => Scaffold(
              appBar: AppBar(title: const Text('Phone Number Widget')),
              body: const Center(
                child:
                    PhoneNumberWidget('+18585551212', "(858) 555-1212", "home"),
              )))
    ];

    return Storybook(stories: stories);
  }
}
