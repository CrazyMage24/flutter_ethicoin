import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'user.dart';

/// milyen eventek lehetnek
enum Event { home, login, edit, editSave }

/// Bloc State-k
@immutable
abstract class BlocState {}

class HomeState extends BlocState {}

class LoginState extends BlocState {}

class EditState extends BlocState {}

/// Bloc osztály
class MyBloc extends Bloc<Event, BlocState>
{
  String email = "";
  String username = "";
  String label = "";
  int userindex = 0;

  /// Konkrét Userek listája
  List<User> users =
  [
    new User("gaborszentes9@gmail.com", "crazymage", 21, "male", "Gábor"),
    new User("valami@freemail.com", "idname", 20, "female", "Rose"),
    new User("asd", "asd", 50, "male", "Josef"),
  ];

  /// létezik-e az emailhez tartozó user
  bool UserExists()
  {
    for(int i = 0; i < users.length; i++)
    {
      if(email == users[i].email)
      {
        userindex = i;
        return true;
      }
    }
    return false;
  }

  /// emailhez tartozó user visszaadása
  User returnUser()
  {
    return users[userindex];
  }

  updateEmail(String text) {
    this.email = text;
  }

  updateUsername(String text)
  {
    this.username = text;
  }

  getlabel()
  {
    return label;
  }

  /// home page-n kezdünk
  MyBloc() : super(HomeState());

  @override
  Stream<BlocState> mapEventToState(Event event) async*
  {
    if(event == Event.home)
    {
      /// térjünk vissza a home page-re
      print("home");
      yield HomeState();
    }
    else if(event == Event.login)
    {
      /// ha létezik a user, akkor loginoljunk be
      if(UserExists())
      {
        print("login");
        yield LoginState();
      }
    }
    else if(event == Event.edit)
    {
      /// meg akarjuk változtatni a username-t
      print("edit");
      yield EditState();
    }
    else if(event == Event.editSave)
    {
      User user = returnUser();
      /// el akarjuk menteni az új username-t
      if(username.length < 6 && user.username != username)
      {
        print("too short");
        label = "too short";
      }
      else if(username.length > 20 && user.username != username)
      {
        print("too long");
        label = "too long";
      }
      else
      {
        print("accepted");
        label = "";
        users[userindex].username = username;
        yield LoginState();
      }
    }
  }
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// State alapján jelenítjük meg a page-t
      home: BlocBuilder<MyBloc, BlocState>(
          builder: (_, state) => (state is HomeState ? HomePage() : (state is LoginState ? LoginPage() : EditPage()))
      ),
    );
  }
}

class HomePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column
        (
        children:
        [
          TextField(
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                contentPadding: EdgeInsets.all(20.0),
              ),
              onChanged: (text) {
                BlocProvider.of<MyBloc>(context).updateEmail(text);
              }
          )
          ,
          ElevatedButton
            (

            child: Text('Log in'),
            onPressed: ()
            {
              Future.delayed(Duration(milliseconds: 2000), () => BlocProvider.of<MyBloc>(context).add(Event.login));

            },
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: UserInfo(),
    );
  }
}

class UserInfo extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    User user = BlocProvider.of<MyBloc>(context).returnUser();
    return ListView
      (
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.amber[600],
          child: Center(child: Text(user.email)),
        ),
        Container(
            height: 50,
            color: Colors.amber[400],
            child: Row
              (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Center
                (
                  child: Text(user.username),
                ),
                Center
                  (
                  child: IconButton
                    (
                      icon: const Icon(Icons.mode_edit_outline_outlined),
                      tooltip: 'Change username',
                      onPressed: ()
                      {
                        BlocProvider.of<MyBloc>(context).add(Event.edit);
                      }
                  ),
                )
              ],
            )
        ),
        Container(
          height: 50,
          color: Colors.amber[600],
          child: Center(child: Text(user.age.toString())),
        ),
        Container(
          height: 50,
          color: Colors.amber[400],
          child: Center(child: Text(user.gender)),
        ),
        Container(
          height: 50,
          color: Colors.amber[600],
          child: Center(child: Text(user.realname)),
        ),
        ElevatedButton
          (
          child: Text('Log out'),
          onPressed: ()
          {
            BlocProvider.of<MyBloc>(context).add(Event.home);
          },
        ),
      ],
    );
  }
}

class EditPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Page'),
      ),
      body: UserEditInfo(),
    );
  }
}

class UserEditInfo extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    User user = BlocProvider.of<MyBloc>(context).returnUser();
    return ListView
      (
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.amber[600],
          child: Center(child: Text(user.email)),
        ),
        Container
          (
            height: 50,
            color: Colors.amber[400],
            child: Row
              (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Container(
                  width: 400.0,
                  child:TextField
                    (
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                      onChanged: (text) {
                        BlocProvider.of<MyBloc>(context).updateUsername(text);
                      }
                  ),
                ),
                Center
                  (
                  child: IconButton
                    (
                      icon: const Icon(Icons.add_task),
                      tooltip: 'Save username',
                      onPressed: ()
                      {
                        Future.delayed(Duration(milliseconds: 2000), () => BlocProvider.of<MyBloc>(context).add(Event.editSave));
                      }
                  ),
                ),
                Center
                (
                  child: Text
                  (
                    BlocProvider.of<MyBloc>(context).getlabel(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.red[600],
                    ),
                  )
                ),
              ],
            )
        ),
        Container(
          height: 50,
          color: Colors.amber[600],
          child: Center(child: Text(user.age.toString())),
        ),
        Container(
          height: 50,
          color: Colors.amber[400],
          child: Center(child: Text(user.gender)),
        ),
        Container(
          height: 50,
          color: Colors.amber[600],
          child: Center(child: Text(user.realname)),
        ),
        ElevatedButton
          (
          child: Text('Log out'),
          onPressed: ()
          {
            BlocProvider.of<MyBloc>(context).add(Event.home);
          },
        ),
      ],
    );
  }
}

void main()
{
  runApp(
    BlocProvider(
      create: (context) => MyBloc(),
      child: MyApp(),
    ),
  );
}