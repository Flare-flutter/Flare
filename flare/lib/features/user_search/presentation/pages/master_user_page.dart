import 'package:flare/features/user_search/presentation/bloc/bloc.dart';
import 'package:flare/features/user_search/presentation/bloc/user_search_bloc.dart';
import 'package:flare/features/user_search/presentation/widgets/user_search.dart';
// import 'package:clean_architecture_tdd_course/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flare'),
        actions: <Widget>[UserSearchButton(bloc: sl<UserSearchBloc>())],
      ),
      body: SingleChildScrollView(
        child: null, //buildBody(context),
      ),
    );
  }

  // BlocProvider<UserSearchBloc> buildBody(BuildContext context) {
  //   return BlocProvider(
  //     create: (_) => sl<UserSearchBloc>(),
  //     child: Center(
  //       child: Padding(
  //         padding: const EdgeInsets.all(10),
  //         child: Column(
  //           children: <Widget>[
  //             SizedBox(height: 10),
  //             // Top half
  //             BlocBuilder<UserSearchBloc, NumberTriviaState>(
  //               builder: (context, state) {
  //                 if (state is Empty) {
  //                   return MessageDisplay(
  //                     message: 'Start searching!',
  //                   );
  //                 } else if (state is Loading) {
  //                   return LoadingWidget();
  //                 } else if (state is Loaded) {
  //                   return TriviaDisplay(numberTrivia: state.trivia);
  //                 } else if (state is Error) {
  //                   return MessageDisplay(
  //                     message: state.message,
  //                   );
  //                 }
  //               },
  //             ),
  //             SizedBox(height: 20),
  //             // Bottom half
  //             TriviaControls()
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
