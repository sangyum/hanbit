import 'package:hanbit_directory/src/models/contact.dart';
import 'package:hanbit_directory/src/proxy/search_people.dart';

class MockSearchPeople implements SearchPeople {
  @override
  Future<List<Contact>> search(String term) {
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

    return Future.value(contacts);
  }
}