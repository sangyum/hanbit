import 'dart:convert';
import 'dart:io';
import 'package:hanbit_directory/src/models/contact.dart';
import 'package:hanbit_directory/src/proxy/planningCenter/people_response.dart';
import 'package:hanbit_directory/src/proxy/search_people.dart';
import 'package:http/http.dart' as http;

class PlanningCenter implements SearchPeople {
  final String peopleSearchUrl =
      "https://api.planningcenteronline.com/people/v2/people";
  final String applicationId =
      const String.fromEnvironment('PLANNING_CENTER_APPLICATION_ID');
  final String secret = const String.fromEnvironment('PLANNING_CENTER_SECRET');

  String authToken = "";

  PlanningCenter() {
    authToken = base64.encode(utf8.encode('$applicationId:$secret'));
  }

  @override
  Future<List<Contact>> search(String term) async {
    final url =
        '$peopleSearchUrl&where[given_name]=$term&include=emails,phone_numbers';
    final response = await http.get(Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Basic $authToken'});

    final responseJson = jsonDecode(response.body);
    final peopleResponse = PeopleResponse.fromJson(responseJson);

    return peopleResponse.people
        .map((person) => Contact(
            person.attributes.koreanName,
            person.attributes.englishName,
            '8585551212',
            'sang.yum@sdhanbit.org',
            person.attributes.birthdate,
            person.attributes.avatar))
        .toList();
  }
}
