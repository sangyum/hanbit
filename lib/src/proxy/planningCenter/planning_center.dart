import 'dart:convert';
import 'dart:io';
import 'package:hanbit_directory/src/models/contact.dart';
import 'package:hanbit_directory/src/proxy/planningCenter/people_response.dart';
import 'package:hanbit_directory/src/proxy/search_people.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PlanningCenter implements SearchPeople {
  final String hostname = "api.planningcenteronline.com";
  final String peopleSearchBaseUrl = "/people/v2/people";

  final String applicationId =
      const String.fromEnvironment('PLANNING_CENTER_APPLICATION_ID');
  final String secret = const String.fromEnvironment('PLANNING_CENTER_SECRET');

  String authToken = "";

  PlanningCenter() {
    authToken = base64.encode(utf8.encode('$applicationId:$secret'));
  }

  Future<Response> get(String path, Map<String, String> queryParams) {
    var headers = {
      HttpHeaders.authorizationHeader: 'Basic $authToken',
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    final uri = Uri.https(hostname, path, queryParams);

    return http.get(uri, headers: headers);
  }

  @override
  Future<List<Contact>> search(String term) async {
    List<Contact> searchResult = List.empty(growable: true);

    var queryParams = {
      'include': 'emails,phone_numbers',
      'where[given_name]': "%$term%"
    };

    var response = await get(peopleSearchBaseUrl, queryParams);
    if (response.statusCode != HttpStatus.ok) {
      return searchResult;
    }

    final responseJson = jsonDecode(response.body);
    final peopleResponse = PeopleResponse.fromJson(responseJson);

    for (Person person in peopleResponse.people) {
      var phoneNumbers =
          peopleResponse.get<PhoneNumber>(person.relationships.phoneNumberIds);
      var emails = peopleResponse.get<Email>(person.relationships.emailIds);

      var contact = Contact(
          person.attributes.koreanName,
          person.attributes.englishName,
          phoneNumbers,
          emails,
          person.attributes.birthdate,
          person.attributes.avatar);

      searchResult.add(contact);
    }

    return searchResult;
  }
}
