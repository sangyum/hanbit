import 'dart:convert';
import 'dart:io';
import 'package:hanbit_directory/src/proxy/planningCenter/people_response.dart';
import 'package:test/test.dart';

void main() {
  var currentDir = "${Directory.current.path}/lib/test/proxy/planningCenter";

  test('should deserialize people response', () {
    var filePath = "$currentDir/people_response.json";
    var jsonString = File(filePath).readAsStringSync();

    final parsedJson = jsonDecode(jsonString);
    final peopleResponse = PeopleResponse.fromJson(parsedJson);

    expect(peopleResponse.people.length, 25);
  });

  test('should deserialize people response with additional attributes', () {
    var filePath = "$currentDir/people_response_with_email.json";
    var jsonString = File(filePath).readAsStringSync();

    final parsedJson = jsonDecode(jsonString);
    final peopleResponse = PeopleResponse.fromJson(parsedJson);

    expect(peopleResponse.people.length, 1);
    expect(peopleResponse.metadata.keys.length, 3);

    final person = peopleResponse.people[0];
    expect(person.relationships.emailIds.length, 2);

    final emails = peopleResponse.get<Email>(person.relationships.emailIds);
    expect(emails[0].address, "sang.yum@sdhanbit.org");
  });
}
