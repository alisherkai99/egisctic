part of 'people.cubit.dart';

@immutable
abstract class PeopleState {}

class PeopleInitial extends PeopleState {}

class PeopleLoaded extends PeopleState {
  final List<Person> people;

  PeopleLoaded(this.people);
}

class PeopleLoading extends PeopleState {
  final List<Person> oldPeople;
  final bool isFirstFetch;

  PeopleLoading(this.oldPeople, {this.isFirstFetch = false});
}
