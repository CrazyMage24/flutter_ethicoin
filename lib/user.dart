import 'package:equatable/equatable.dart';

/// User class
class User extends Equatable
{
  String email;
  String username;
  int age;
  String gender;
  String realname;

  User(this.email, this.username, this.age, this.gender, this.realname);

  @override
  List<Object?> get props => [email,username,age,gender,realname];
}