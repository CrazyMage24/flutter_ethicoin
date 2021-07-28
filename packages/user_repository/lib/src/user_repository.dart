import 'dart:async';
import 'models/models.dart';

class UserRepository
{
  // userek listája, akikhez be lehet lépni
  List<User> users =
  [
    new User("gaborszentes9@gmail.com", "crazymage", 21, "male", "Gábor"),
    new User("valami@freemail.com", "idname", 20, "female", "Rose"),
  ];

  // megnézi, létezik-e olyan user, akinek az emailjét beírták, majd 2 sec után visszadja
  Future<User> getUser(String email) async
  {
    for(int i = 0; i < users.length; i++)
    {
      if(users[i].email == email)
      {
        return Future.delayed
        (
          const Duration(milliseconds: 2000), () => users[i]
        );
      }
    }
    throw Exception("Nincs ilyen felhasználó");
  }
}