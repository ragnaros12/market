part of 'api_bloc.dart';

@immutable
abstract class ApiState {}

class ApiInitial extends ApiState {}

class LoginFail extends ApiState{

}

class GetOrdersState extends ApiState{
  List<Order> orders;

  GetOrdersState(this.orders);
}