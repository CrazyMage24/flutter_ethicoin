import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return const MaterialApp
    (
      title: 'EthiCoin feladat',
      home: EmailForm(),
    );
  }
}

// Define a custom Form widget.
class EmailForm extends StatefulWidget
{
  const EmailForm({Key? key}) : super(key: key);

  @override
  _EmailFormState createState() => _EmailFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _EmailFormState extends State<EmailForm>
{
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  //List of integers
  List<User> users =
  [
    new User("gaborszentes9@gmail.com", "crazymage", 21, "male", "Gábor"),
    new User("valami@freemail.com", "idname", 17, "female", "Rose"),
  ];

  @override
  void dispose()
  {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('Email Form'),
      ),
      body: Padding
      (
        padding: const EdgeInsets.all(32.0),
        child: Column
        (
          children:
          [
            TextFormField
            (
            controller: myController,
            decoration: const InputDecoration
              (
                border: OutlineInputBorder(),
                hintText: 'Email'
              ),
            ),
          OutlinedButton
          (
            onPressed: ()
            {
              checkUser(users,myController.text);
            },
            child: const Text('Submit'),
          ),
          ]
        ),
      ),
    );
  }
}

void checkUser(List<User> users, String text)
{
  for(int i = 0; i < users.length;i++)
    {
      if(users[i].email == text)
      {
        print("találat");
      }
      else
      {
        print("nincs találat");
      }
    }
}

class User
{
  String email;
  String username;
  int age;
  String gender;
  String real_name;

  User(this.email, this.username, this.age, this.gender, this.real_name);
}


