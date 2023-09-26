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

  List<T> get<T extends Metadata>(List<String> ids) {
    return ids.map((id) => metadata[id] as T).toList();
  }

  T? getPrimary<T extends Metadata>(List<String> ids) {
    return ids
        .map((id) => metadata[id] as T)
        .where((element) => element.primary)
        .firstOrNull;
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
  late Relationships relationships;
  late Links links;

  Person(this.type, this.id, this.attributes, this.links);

  Person.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    attributes = Attributes.fromJson(json['attributes']);
    relationships = Relationships.fromJson(json['relationships']);
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

class Relationships {
  late List<String> emailIds;
  late List<String> phoneNumberIds;

  Relationships(this.emailIds, this.phoneNumberIds);

  Relationships.fromJson(Map<String, dynamic> json) {
    for (String key in json.keys) {
      if (key == 'emails' || key == 'phone_numbers') {
        var dataList = json[key]['data'] as List<dynamic>;

        if (key == 'emails') {
          emailIds = dataList
              .map((e) => e as Map<String, dynamic>)
              .map((e) => e['id'] as String)
              .toList();
        } else {
          phoneNumberIds = dataList
              .map((e) => e as Map<String, dynamic>)
              .map((e) => e['id'] as String)
              .toList();
        }
      }
    }
  }
}

abstract class Metadata {
  final String id;
  final String type;
  final bool primary;
  final String location;

  Metadata(this.id, this.type, this.primary, this.location);
}

class Email extends Metadata {
  final String address;

  Email(String id, String type, bool primary, this.address, location)
      : super(id, type, primary, location);

  Email.fromJson(Map<String, dynamic> json)
      : address = json['attributes']['address'],
        super(json['id'], json['type'], json['attributes']['primary'] == 'true',
            json['attributes']['location']);
}

class PhoneNumber extends Metadata {
  final String number;

  PhoneNumber(
      String id, String type, bool primary, this.number, String location)
      : super(id, type, primary, location);

  PhoneNumber.fromJson(Map<String, dynamic> json)
      : number = json['attributes']['number'],
        super(json['id'], json['type'], json['attributes']['primary'] == 'true',
            json['attributes']['location']);
}
