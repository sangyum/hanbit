import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hanbit_directory/src/models/contact.dart';
import 'package:hanbit_directory/src/widgets/contact_tile.dart';

class ContactTileList extends StatelessWidget {
  final List<Contact> contacts;

  const ContactTileList(this.contacts, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      restorationId: 'contactTileList',
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        final contact = contacts[index];

        return ContactTile(contact);
      },
    );
  }
}
