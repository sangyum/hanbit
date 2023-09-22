import 'package:flutter/material.dart';
import 'package:hanbit_directory/src/models/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;

  const ContactTile(this.contact, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(contact.avatar),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${contact.koreanName} (${contact.englishName})'),
              Text(contact.email),
              Text(contact.phoneNumber),
            ],
          ),
        ),
      ],
    );
  }
}
