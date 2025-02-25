import 'package:flutter/material.dart';
import 'details.dart';
import 'home.dart';
import 'menu.dart';
import 'summary.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/menu": (context) => const Menu(),
        "/details": (context) => const Details(),
        "/summary": (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return Summary(
            cartItems: List<Map<String, dynamic>>.from(args['cartItems']),
            totalQuantity: args['totalQuantity'] as int,
            totalPrice: args['totalPrice'] as int,
          );
        },
      },
    ));
