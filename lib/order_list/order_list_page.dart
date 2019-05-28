import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/authentication.dart';

class OrderListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      child: Column(
        children: <Widget>[
          // Center(
          //   child: RaisedButton(
          //     child: Text('logout'),
          //     onPressed: () {
          //       authenticationBloc.dispatch(LoggedOut());
          //     },
          //   ),
          // ),
          // Center(
          //   child: RaisedButton(
          //     child: Text('ValidateUser'),
          //     onPressed: () {
          //       authenticationBloc.dispatch(ValidateUser());
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
