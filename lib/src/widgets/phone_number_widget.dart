import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneNumberWidget extends StatelessWidget {
  final String e164;
  final String number;
  final String location;

  const PhoneNumberWidget(this.e164, this.number, this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text("$number ($location)"),
      onPressed: () async {
        Uri phoneNo = Uri.parse("tel:$e164");
        if (await launchUrl(phoneNo)) {
          log('dialer opened');
        } else {
          log('dialer not opened');
        }
      },
    );
  }
}
