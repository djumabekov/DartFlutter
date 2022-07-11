import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/persons/bloc_persons.dart';
import 'package:flutter_application_1/repo/api.dart';
import 'package:flutter_application_1/repo/repo_settings.dart';
import 'package:flutter_application_1/repo/repo_persons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitWidget extends StatelessWidget {
  const InitWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => Api(),
        ),
        RepositoryProvider(
          create: (context) => RepoSettings(),
        ),
        RepositoryProvider(
          create: (context) => RepoPersons(
            api: RepositoryProvider.of<Api>(context),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BlocPersons(
              repo: RepositoryProvider.of<RepoPersons>(context),
            )..add(EventPersonsFilterByName('')),
          ),
        ],
        child: child,
      ),
    );
  }
}
