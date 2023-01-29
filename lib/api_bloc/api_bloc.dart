import 'package:app2/models/order.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../core/api.dart';
import 'dart:convert';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  
  Api api = Api(Dio());
  String? auth;
  
  ApiBloc() : super(ApiInitial()) {
    on<ApiEvent>((event, emit) async {
      if(event is LoginClickEvent){
        auth = "Basic ${base64Encode(utf8.encode("${event.login}:${event.password}"))}";
        try {
          await api.authorize(auth!);
          add(GetOrderClickEvent());
        }
        catch(e) {
          debugPrint(e.toString());
          emit(LoginFail());
        }
      }
      else if(event is GetOrderClickEvent){
        List<Order> orders = await api.getOrders(auth!);
        emit(GetOrdersState(orders));
      }
    });
  }
}
