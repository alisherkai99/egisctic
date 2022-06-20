import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swapi_test/data/models/person.entity.dart';
import 'package:swapi_test/data/repositories/people.respository.dart';

part 'people.state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit(this.repository) : super(PeopleInitial());

  int page = 1;
  final PeopleRepository repository;

  void loadPeople() {
    if (state is PeopleLoading) return;

    final currentState = state;

    var oldPeople = <Person>[];
    if (currentState is PeopleLoaded) {
      oldPeople = currentState.people;
    }

    emit(PeopleLoading(oldPeople, isFirstFetch: page == 1));

    repository.fetchPeople(page).then((newPeople) {
      page++;

      final people = (state as PeopleLoading).oldPeople;
      people.addAll(newPeople);

      emit(PeopleLoaded(people));
    });
  }
}
