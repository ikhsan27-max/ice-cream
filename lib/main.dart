import 'package:flutter/material.dart';
import 'package:taxi_booking/settings.dart';
import 'details.dart';
import 'home.dart';
import 'menu.dart';
import 'summary.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/": (context) => const Splash(),
      "/menu": (context) => const Menu(),
      "/details": (context) => const Details(),
      "/summary": (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

        return Summary(
          cartItems: List<Map<String, dynamic>>.from(
            args['cartItems'] as List<dynamic>,
          ),
          totalQuantity: (args['totalQuantity'] as num).toDouble(),
          totalPrice: (args['totalPrice'] as num).toDouble(),
        );
      },
      "/settings": (context) => const Settings(),
    },
  ),
);
