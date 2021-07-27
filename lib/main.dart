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
  bool validuser = false;
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
    if(!validuser)
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
                    validuser = checkUser(users,myController.text);
                  },
                  child: const Text('Submit'),
                ),
              ]
          ),
        ),
      );
    }
    else
    {
      return user_data;
    }
  }
}

bool checkUser(List<User> users, String text)
{
  for(int i = 0; i < users.length;i++)
    {
      if(users[i].email == text)
      {
        print("találat");
        return true;
      }
      else
      {
        print("nincs találat");
        return false;
      }
    }
  return false;
}

ListView user_data = ListView(
  padding: const EdgeInsets.all(8),
  children: <Widget>
  [
    // email
    Container
    (
      height: 50,
      color: Colors.amber[600],
      child: const Center(child: Text('Entry A')),
    ),
    // username
    Container
    (
      height: 50,
      color: Colors.amber[500],
      child: const Center(child: Text('Entry B')),
    ),
    // age
    Container
    (
      height: 50,
      color: Colors.amber[400],
      child: const Center(child: Text('Entry C')),
    ),
    // gender
    Container
      (
      height: 50,
      color: Colors.amber[300],
      child: const Center(child: Text('Entry C')),
    ),
    // real name
    Container
      (
      height: 50,
      color: Colors.amber[200],
      child: const Center(child: Text('Entry C')),
    ),
  ],
);

class User
{
  String email;
  String username;
  int age;
  String gender;
  String real_name;

  User(this.email, this.username, this.age, this.gender, this.real_name);
}


