import 'package:flare/features/user_search/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flare/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSearchButton extends StatelessWidget {
  final UserSearchBloc bloc;

  UserSearchButton({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(bloc),
        );
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final UserSearchBloc bloc;
  CustomSearchDelegate(this.bloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  BlocProvider<UserSearchBloc> buildResults(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserSearchBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<UserSearchBloc, UserSearchState>(
                builder: (context, state) {
                  BlocProvider.of<UserSearchBloc>(context)
                      .add((SearchForUsersEvent(query)));

                  if (state is Empty) {
                    return Text(
                      'Start searching!',
                    );
                  } else if (state is Loading) {
                    return CircularProgressIndicator();
                  } else if (state is Loaded) {
                    return Column(
                      children: state.result
                          .map((curr) => ListTile(
                              title:
                                  Text("${curr.firstName} ${curr.lastName}")))
                          .toList(),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              // TriviaControls()
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget buildResults(BuildContext context) {
  //   if (query.length < 3) {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Center(
  //           child: Text(
  //             "Search term must be longer than two letters.",
  //           ),
  //         )
  //       ],
  //     );
  //   }

  //   // bloc.add(SearchForUsersEvent(query));
  //   sl<UserSearchBloc>().add(SearchForUsersEvent(query));

  //   return Column(children: [
  //     StreamBuilder(
  //         stream: ,
  //         builder: (context, snapshot) {
  //           if (!snapshot.hasData) {
  //             return Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 Center(child: CircularProgressIndicator()),
  //               ],
  //             );
  //           } else if (snapshot.data.length == 0) {
  //             return Column(
  //               children: <Widget>[
  //                 Text(
  //                   "No Results Found.",
  //                 ),
  //               ],
  //             );
  //           } else {
  //             var results = snapshot.data;
  //             print('#### $results');
  //             return ListView.builder(
  //               itemCount: results.length,
  //               itemBuilder: (context, index) {
  //                 // var result = results[index];
  //                 return ListTile(
  //                   title: Text("asd"),
  //                 );
  //               },
  //             );
  //           }
  //         })
  //   ]);
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
