import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/app_config.dart';
import 'package:orders_app/order_list/order_list_bloc.dart';
import 'package:orders_app/order_list/order_list_event.dart';
import 'package:orders_app/order_list/order_list_state.dart';
import '../authentication/authentication.dart';
import '../order_list/order_list.dart';
import '../order_new/order_new.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    final OrderListBloc orderListBloc = OrderListBloc();

    var pageToRender;
    var floattingButtonToRender;

    void goTo() {
      orderListBloc.dispatch(NewOrder());

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderNewPage()),
      );
    }

    Widget renderFloating(String event) {
      Icon _icon;
      Function _onPressed;
      switch (event) {
        case 'new':
          _icon = Icon(Icons.add);
          _onPressed = goTo;
          break;
        case 'cancel':
          _icon = Icon(Icons.close);
          _onPressed = () => {orderListBloc.dispatch(CancelOrder())};
          break;
        case 'save':
          _icon = Icon(Icons.save);
          _onPressed = () => {orderListBloc.dispatch(CancelOrder())};
          break;
        case 'empty':
          return new Container();
          break;
        default:
      }

      return new FloatingActionButton(
          elevation: 0.0,
          child: _icon,
          backgroundColor: Theme.of(context).accentColor,
          onPressed: () => {_onPressed()});
    }

    return BlocBuilder<OrderListEvent, OrderListState>(
        bloc: orderListBloc,
        builder: (
          BuildContext context,
          OrderListState state,
        ) {
          if (state is StartNewOrder) {
            // floattingButtonToRender = renderFloating('new');
          }

          if (state is CancelNewOrder) {
            // pageToRender = OrderListPage();
            // floattingButtonToRender = renderFloating('new');
          }

          if (state is OrderListUninitialized) {
            pageToRender = OrderListPage();
            floattingButtonToRender = renderFloating('new');
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Home'),
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: (String selected) {
                    print(selected);
                    if (selected == 'logout') {
                      authenticationBloc.dispatch(LoggedOut());
                      // AppConfig().setThemeConfig('default');
                      // authenticationBloc.inTheme(AppConfig().themeData);
                    }
                    if (selected == 'changeTheme') {
                      print('HomePage - 91');
                      print(AppConfig().themeName);
                      if (AppConfig().themeName == 'light') {
                        AppConfig().setThemeConfig('dark');
                        authenticationBloc.inTheme(AppConfig().themeData);
                      } else if (AppConfig().themeName == 'dark') {
                        AppConfig().setThemeConfig('light');
                        authenticationBloc.inTheme(AppConfig().themeData);
                      } else if (AppConfig().themeName == 'default') {
                        AppConfig().setThemeConfig('dark');
                        authenticationBloc.inTheme(AppConfig().themeData);
                      }
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuItem<String>>[
                        const PopupMenuItem<String>(
                          value: 'changeTheme',
                          child: ListTile(
                            trailing: Icon(Icons.smartphone),
                            title: Text('Trocar Tema'),
                          ),
                        ),
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
            floatingActionButton: floattingButtonToRender,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: pageToRender,
          );
        });
  }
}
