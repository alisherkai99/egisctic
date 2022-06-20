import 'dart:convert';
import 'package:http/http.dart';

class PeopleService {
  final baseUrl = "https://swapi.dev/api/people";

  Future<List<dynamic>> fetchPeople(int page) async {
    try {
      final response =
          await get(Uri.parse(baseUrl + "/?page=$page&?format=json"));

      final json = jsonDecode(response.body);
      return json['results'] as List<dynamic>;
    } catch (err) {
      return [];
    }
  }
}
