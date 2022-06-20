import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swapi_test/cubit/people.cubit.dart';
import 'package:swapi_test/data/repositories/people.respository.dart';
import 'package:swapi_test/data/services/people.service.dart';
import 'package:swapi_test/presentation/screens/people/people.screen.dart';

void main() {
  runApp(PeoplePaginationApp(
    repository: PeopleRepository(PeopleService()),
  ));
}

class PeoplePaginationApp extends StatelessWidget {
  final PeopleRepository repository;

  const PeoplePaginationApp({Key key, this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => PeopleCubit(repository),
        child: PeopleView(),
      ),
    );
  }
}
