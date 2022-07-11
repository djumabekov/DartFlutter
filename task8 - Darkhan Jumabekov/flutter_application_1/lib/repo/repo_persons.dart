import 'package:flutter_application_1/person.dart';
import 'api.dart';

class RepoPersons {
  RepoPersons({required this.api});
  final Api api;

  Future<ResultRepoPersons> filterByName(String name) async {
    try {
      final result = await api.dio.get(
        '/character/',
        queryParameters: {
          "name": name,
        },
      );

      final List personsListJson = result.data['results'] ?? [];
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
