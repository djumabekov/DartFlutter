import 'dart:convert';
import 'package:flutter_application_1/person.dart';
import 'package:http/http.dart' as http;

class RepoPersons {
  Future<ResultRepoPersons> readPersons() async {
    try {
      final url = Uri.parse('https://rickandmortyapi.com/api/character');
      final result = await http.get(url);
      final data = jsonDecode(result.body);
      final personsListJson = data['results'] as List;
      final personsList = personsListJson
          .map(
            (item) => Person.fromJson(item),
          )
          .toList();
      return ResultRepoPersons(personsList: personsList);
    } catch (error) {
      print('🏐 Error : $error');
      return ResultRepoPersons(
        errorMessage: "",
      );
    }
  }
}

class ResultRepoPersons {
  ResultRepoPersons({
    this.errorMessage,
    this.personsList,
  });

  final String? errorMessage;
  final List<Person>? personsList;
}
