
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;


//customer pending details
var customer1 = const CustomerUrgentDetails('Justin', Icon(Icons.person), 1);
var customer5 = const CustomerUrgentDetails('Mercado', Icon(Icons.person), 1);
var customer6 = const CustomerUrgentDetails('Justin', Icon(Icons.person), 1);
var customer2 = const CustomerUrgentDetails('Mercado', Icon(Icons.person), 1);
var customer3 = const CustomerUrgentDetails('Justin', Icon(Icons.person), 1);

List<CustomerUrgentDetails> listOfCustomerurgent = [
  customer1,
  customer5,
  customer5,
  customer2,
  customer3,
  customer5,
  customer5,
  customer2,
  customer3,
  customer5,
  customer6,
];

class CustomerUrgentDetails {
  final String name;
  final Widget icon;
  final int time;
  const CustomerUrgentDetails(this.name, this.icon, this.time);
}


// today earnings


//monthly earning

//all earnings

//expenses


//individuall product sales and numbers


//total order


//customer list - name, and place

//news