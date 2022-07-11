import 'package:flutter/material.dart';
import 'package:flutter_application_1/person.dart';
import 'package:flutter_application_1/repo/repo_persons.dart';

class PersonsListVModel with ChangeNotifier {
  PersonsListVModel({required this.repo}) {
    _init();
  }

  String? errorMessage;
  List<Person> filteredList = <Person>[];
  bool isListView = false;
  var isLoading = true;
  final RepoPersons repo;

  var _personsList = <Person>[];

  void _init() {
    repo.readPersons().then((result) {
      errorMessage = result.errorMessage;
      _personsList = result.personsList ?? <Person>[];
      filteredList = _personsList;
      isLoading = false;
      notifyListeners();
    });
  }

  void filter(String query) {
    filteredList = _personsList.where((element) {
      if (element.name == null) return false;
      final name = element.name!.toLowerCase();
      return name.contains(query);
    }).toList();
    notifyListeners();
  }

  void switchView() {
    isListView = !isListView;
    notifyListeners();
  }
}
