import 'package:app2/api_bloc/api_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'models/order.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            body: BlocProvider<ApiBloc>(
                create: (build) => ApiBloc(),
                child:
                    BlocBuilder<ApiBloc, ApiState>(builder: (context, state) {
                  if (state is LoginFail) {
                    Fluttertoast.showToast(
                        msg: "Ошибка входа", toastLength: Toast.LENGTH_LONG);
                  }
                  if (state is ApiInitial || state is LoginFail) {
                    return AuthPage();
                  } else if (state is GetOrdersState) {
                    return MainPage(state.orders);
                  }
                  return Container();
                }))));
  }
}

class AuthPage extends StatelessWidget {
  TextEditingController loginController =
          TextEditingController(text: "Екатерина"),
      passwordController = TextEditingController(text: "6507276063tT!");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.orange,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Text("АВТОРИЗАЦИЯ",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            const SizedBox(height: 50),
            TextField(
                controller: loginController,
                decoration: InputDecoration(
                    labelText: "Введите логин",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        )))),
            const SizedBox(height: 10),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: "Введите пароль",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        )))),
            const SizedBox(height: 40),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          )),
                      color: Colors.orange,
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          child: const Text("ВОЙТИ",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17)))),
                  onTap: () async {
                    context.read<ApiBloc>().add(LoginClickEvent(
                        login: loginController.text,
                        password: passwordController.text));
                  },
                ),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        )),
                    color: Colors.orange,
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text("ОТМЕНА",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  List<Order> orders;

  MainPage(this.orders);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 10),
        Expanded(
            child: ListView.builder(
                itemBuilder: buildItemList, itemCount: orders.length)),
        const SizedBox(height: 10),
        Center(
            child: InkWell(
          child: Card(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: const Text("Обновить"),
            ),
          ),
          onTap: () {
            context.read<ApiBloc>().add(GetOrderClickEvent());
          },
        )),
        const SizedBox(height: 10)
      ],
    );
  }

  Widget buildItemList(BuildContext context, int position) {
    Order order = orders[position];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1)
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderItemPage(order)));
        },
        child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(order.foto, width: 100),
              Expanded(
                  child: Column(
                    children: [
                      Text(order.name),
                      const SizedBox(height: 10),
                      Text(order.place)
                    ],
                  )),
            ],
          ),
      ));
  }
}


class OrderItemPage extends StatelessWidget{
  Order order;
  
  OrderItemPage(this.order);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(order.foto),
    );
  }
}