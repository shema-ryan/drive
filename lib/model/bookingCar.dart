import 'package:drive/model/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Order {
  final String email;
  final String id;
  final String location;
  final String name;
  final String startDate;
  final String returnDate;
  final int amount;
  final String date;
  final Car car;
  final String contact;
  final String ninNumber;
  Order({
    @required this.email,
    @required this.location,
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.date,
    @required this.returnDate,
    @required this.startDate,
    @required this.car,
    @required this.contact,
    @required this.ninNumber,
  });
}

class OrderCar extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get getOrders {
    return [..._orders];
  }

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}
