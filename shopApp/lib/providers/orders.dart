import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://my-shop-app-fc71f.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: jsonEncode({
        'amount': total,
        'products': cartProducts
            .map((cartPro) => {
                  'id': cartPro.id,
                  'title': cartPro.title,
                  'quantity': cartPro.quantity,
                  'price': cartPro.price,
                })
            .toList(),
        'dateTime': timeStamp.toIso8601String(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timeStamp,
      ),
    );
    notifyListeners();
  }
}
