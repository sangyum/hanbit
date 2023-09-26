import 'package:hanbit_directory/src/proxy/planningCenter/people_response.dart';

class Contact {
  final String koreanName;
  final String englishName;
  final List<PhoneNumber> phoneNumbers;
  final List<Email> emails;
  final DateTime birthDate;
  final String avatar;

  Contact(this.koreanName, this.englishName, this.phoneNumbers, this.emails,
      this.birthDate, this.avatar);
}
