import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swapi_test/cubit/people.cubit.dart';
import 'package:swapi_test/data/models/person.entity.dart';

class PeopleView extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PeopleCubit>(context).loadPeople();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<PeopleCubit>(context).loadPeople();

    return Scaffold(
      appBar: AppBar(
        title: Text("People"),
      ),
      body: _peopleList(),
    );
  }

  Widget _peopleList() {
    return BlocBuilder<PeopleCubit, PeopleState>(builder: (context, state) {
      if (state is PeopleLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<Person> people = [];
      bool isLoading = false;

      if (state is PeopleLoading) {
        people = state.oldPeople;
        isLoading = true;
      } else if (state is PeopleLoaded) {
        people = state.people;
      }

      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < people.length)
            return _person(people[index], context);
          else {
            Timer(Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });

            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: people.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _person(Person person, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${person.name}",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
