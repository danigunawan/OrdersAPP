import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authentication/authentication.dart';
import '../order_list/order_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            // action button
            // IconButton(
            //   icon: Icon(Icons.exit_to_app),
            //   onPressed: () {
            //     authenticationBloc.dispatch(LoggedOut());
            //   },
            // ),
            PopupMenuButton<String>(
              onSelected: (String selected) {
                print(selected);
                if (selected == 'logout') {
                  authenticationBloc.dispatch(LoggedOut());
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    const PopupMenuItem<String>(
                      value: 'settings',
                      child: ListTile(
                        trailing: Icon(Icons.settings),
                        title: Text('Configurações'),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: ListTile(
                        trailing: Icon(Icons.exit_to_app),
                        title: Text('Sair'),
                      ),
                    ),
                  ],
            ),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: Theme.of(context).accentColor,
            onPressed: () {}),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: OrderListPage());
  }
}
