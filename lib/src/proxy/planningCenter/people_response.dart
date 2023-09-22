class PeopleResponse {
  late Links links;
  late List<Person> people;
  late Map<String, Metadata> metadata = {};

  PeopleResponse(this.links, this.people);

  PeopleResponse.fromJson(Map<String, dynamic> json) {
    links = Links.fromJson(json['links']);
    final List<dynamic> data = json['data'];
    people =
        data.map((e) => Person.fromJson(e as Map<String, dynamic>)).toList();

    final List<dynamic> included = json['included'];

    var additionalAttributes = included
        .map((e) => e as Map<String, dynamic>)
        .map((json) => json['type'] == 'PhoneNumber'
            ? PhoneNumber.fromJson(json)
            : Email.fromJson(json))
        .toList();

    for (var attribute in additionalAttributes) {
      metadata[attribute.id] = attribute;
    }
  }
}

class Links {
  final String self;
  final String? next;
  final String? html;

  Links(this.self, this.next, this.html);

  Links.fromJson(Map<String, dynamic> json)
      : self = json['self'],
        next = json['next'],
        html = json['html'];
}

class Person {
  late String type;
  late String id;
  late Attributes attributes;
  late Links links;

  Person(this.type, this.id, this.attributes, this.links);

  Person.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    attributes = Attributes.fromJson(json['attributes']);
    links = Links.fromJson(json['links']);
  }
}

class Attributes {
  final String avatar;
  final DateTime birthdate;
  final String koreanName;
  final String englishName;

  Attributes(this.avatar, this.birthdate, this.koreanName, this.englishName);

  Attributes.fromJson(Map<String, dynamic> json)
      : avatar = json['avatar'],
        birthdate = DateTime.parse(json['birthdate']),
        koreanName = json['given_name'],
        englishName = '${json['first_name']} ${json['last_name']}';
}

abstract class Metadata {
  final String id;
  final String type;

  Metadata(this.id, this.type);
}

class Email extends Metadata {
  final String address;
  final String location;
  final bool primary;

  Email(String id, String type, this.address, this.location, this.primary)
      : super(id, type);

  Email.fromJson(Map<String, dynamic> json)
      : address = json['attributes']['address'],
        location = json['attributes']['location'],
        primary = json['attributes']['primary'] == 'true',
        super(json['id'], json['type']);
}

class PhoneNumber extends Metadata {
  final String number;
  final bool primary;

  PhoneNumber(String id, String type, this.number, this.primary)
      : super(id, type);

  PhoneNumber.fromJson(Map<String, dynamic> json)
      : number = json['attributes']['number'],
        primary = json['attributes']['primary'] == 'true',
        super(json['id'], json['type']);
}
