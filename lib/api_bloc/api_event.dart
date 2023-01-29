part of 'api_bloc.dart';

@immutable
abstract class ApiEvent {}

class LoginClickEvent extends ApiEvent{
  String login, password;

  LoginClickEvent({required this.login, required this.password});
}

class GetOrderClickEvent extends ApiEvent{

}