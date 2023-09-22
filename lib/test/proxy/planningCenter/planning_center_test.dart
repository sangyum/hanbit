import 'dart:convert';
import 'dart:io';
import 'package:hanbit_directory/src/proxy/planningCenter/people_response.dart';
import 'package:test/test.dart';

void main() {
  var currentDir = "${Directory.current.path}/lib/test/proxy/planningCenter";

  test('should deserialize people response', () {
    var filePath =
        "$currentDir/people_response.json";
    var jsonString = File(filePath).readAsStringSync();

    final parsedJson = jsonDecode(jsonString);
    final peopleResponse = PeopleResponse.fromJson(parsedJson);

    expect(peopleResponse.people.length, 25);
  });

  test('should deserialize people response with additional attributes', () {
    var filePath =
        "$currentDir/people_response.json";
    var jsonString = File(filePath).readAsStringSync();

    final parsedJson = jsonDecode(jsonString);
    final peopleResponse = PeopleResponse.fromJson(parsedJson);

    expect(peopleResponse.metadata.keys.length, 3);
  });
}
