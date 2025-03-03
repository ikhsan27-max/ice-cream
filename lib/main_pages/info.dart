import 'package:flutter/material.dart';
import 'package:taxi_booking/widgets/color.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Informasi',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: MyColor.primary,
            ),
          ),
        ),
      ),
    );
  }
}
