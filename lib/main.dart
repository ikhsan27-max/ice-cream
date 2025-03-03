import 'package:flutter/material.dart';
import 'package:taxi_booking/main_pages/main_page.dart';
import 'package:taxi_booking/main_pages/settings.dart';
import 'package:taxi_booking/widgets/color.dart';
import 'details.dart';
import 'home.dart';
import 'main_pages/menu.dart';
import 'summary.dart';

void main() => runApp(
  MaterialApp(
    theme: ThemeData(
      navigationBarTheme: NavigationBarThemeData(
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: MyColor.primary);
          } else {
            return IconThemeData(color: const Color.fromARGB(255, 91, 44, 61));
          }
        }),
      ),
    ),

    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/": (context) => const Splash(),
      "/main": (context) => const MainPage(),
      "/menu": (context) => const Menu(),
      "/settings": (context) => const Settings(),
      "/details": (context) => const Details(),
      '/summary': (context) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

        if (args == null) {
          // Handle case when no arguments are provided
          return Summary(cartItems: [], totalQuantity: 0.0, totalPrice: 0.0);
        }

        return Summary(
          cartItems: List<Map<String, dynamic>>.from(
            args['cartItems'] as List<dynamic>? ?? [],
          ),
          totalQuantity: (args['totalQuantity'] as num?)?.toDouble() ?? 0.0,
          totalPrice: (args['totalPrice'] as num?)?.toDouble() ?? 0.0,
        );
      },
    },
  ),
);
