import 'package:swapi_test/data/models/person.entity.dart';
import 'package:swapi_test/data/services/people.service.dart';

class PeopleRepository {
  final PeopleService service;

  PeopleRepository(this.service);

  Future<List<Person>> fetchPeople(int page) async {
    final results = await service.fetchPeople(page);

    final people = results.map((e) => Person.fromJson(e)).toList();

    return people;
  }
}
