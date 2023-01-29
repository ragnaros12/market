import 'package:app2/models/order.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

@RestApi(baseUrl: "http://176.113.82.105/center/hs/Obmen/v1/")
abstract class Api{
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @POST("/Authorization")
  Future<void> authorize(@Header("Authorization") String basicAuth);
  
  @POST("/getorder/GetInfo")
  Future<List<Order>> getOrders(@Header("Authorization") String basicAuth);
}