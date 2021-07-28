import 'package:equatable/equatable.dart';

class User extends Equatable
{
  String email;
  String username;
  int age;
  String gender;
  String real_name;

  User.empty({this.email = "",this.username = "", this.age = 0, this.gender = "", this.real_name = ""});
  User(this.email,this.username,this.age,this.gender,this.real_name);

  @override
  List<Object> get props => [email,username,age,gender,real_name];
}