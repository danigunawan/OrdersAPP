import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/authentication.dart';
import '../login/login.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      // initialValue: 'hans@hans.com',
      controller: _usernameController,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      // initialValue: 'some password',
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Esqueceu sua Senha?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  onPressed:
                      state is! LoginLoading ? _onLoginButtonPressed : null,
                  child: Text('Entrar', style: TextStyle(color: Colors.white)),

                  padding: EdgeInsets.all(12),
                  color: Colors.lightBlueAccent,
                  // child: Text('Log In', style: TextStyle(color: Colors.white)),
                ),
              ),
              forgotLabel
            ],
          ),
        );

        // return Form(
        //   child: Column(
        //     children: [
        //       // TextFormField(
        //       //   decoration: InputDecoration(labelText: 'username'),
        //       //   controller: _usernameController,
        //       // ),
        //       TextFormField(
        //         keyboardType: TextInputType.emailAddress,
        //         autofocus: false,
        //         // initialValue: 'hans@hans.com',
        //         controller: _usernameController,
        //         decoration: InputDecoration(
        //           hintText: 'Email',
        //           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        //           border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(32.0)),
        //         ),
        //       ),
        //       // TextFormField(
        //       //   decoration: InputDecoration(labelText: 'password'),
        //       //   controller: _passwordController,
        //       //   obscureText: true,
        //       // ),
        //       TextFormField(
        //         autofocus: false,
        //         // initialValue: 'some password',
        //         controller: _passwordController,
        //         obscureText: true,
        //         decoration: InputDecoration(
        //           hintText: 'Password',
        //           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        //           border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(32.0)),
        //         ),
        //       ),
        //       // RaisedButton(
        //       //   onPressed:
        //       //       state is! LoginLoading ? _onLoginButtonPressed : null,
        //       //   child: Text('Login'),
        //       // ),
        //       Padding(
        //         padding: EdgeInsets.symmetric(vertical: 16.0),
        //         child: RaisedButton(
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(24),
        //           ),
        //           onPressed:
        //               state is! LoginLoading ? _onLoginButtonPressed : null,
        //           child: Text('Log In', style: TextStyle(color: Colors.white)),

        //           padding: EdgeInsets.all(12),
        //           color: Colors.lightBlueAccent,
        //           // child: Text('Log In', style: TextStyle(color: Colors.white)),
        //         ),
        //       ),
        //       Container(
        //         child:
        //             state is LoginLoading ? CircularProgressIndicator() : null,
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc.dispatch(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }
}
