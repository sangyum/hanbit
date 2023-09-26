import 'package:hanbit_directory/src/models/contact.dart';
import 'package:hanbit_directory/src/proxy/planningCenter/people_response.dart';
import 'package:hanbit_directory/src/proxy/search_people.dart';

class MockSearchPeople implements SearchPeople {
  @override
  Future<List<Contact>> search(String term) {
    const koreanName = "염상용";
    const englishName = "Sang Yum";
    var phoneNumbers = List.of([
      PhoneNumber('1234', 'PhoneNumber', true, '858-555-1212', 'home'),
      PhoneNumber('1234', 'PhoneNumber', false, '858-633-8454', 'work')
    ]);
    var emails = List.of([
      Email('1234', 'Email', true, 'foo@bar.com', 'home'),
      Email('3456', 'Email', false, 'foo@baz.com', 'work')
    ]);

    var birthDate = DateTime.parse('2022-01-01');
    const avatar =
        "https://avatars.planningcenteronline.com/uploads/person/88055421-1612583333/avatar.1.jpg";

    final contact = Contact(
        koreanName, englishName, phoneNumbers, emails, birthDate, avatar);

    final contacts = Iterable.generate(100).map((i) => contact).toList();

    return Future.value(contacts);
  }
}
