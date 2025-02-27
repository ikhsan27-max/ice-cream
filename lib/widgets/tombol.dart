import 'package:flutter/material.dart';

class tombol extends StatelessWidget {
  const tombol({
    super.key,
    required this.teks,
    required this.bgcolor,
    required this.onpressed,
  });

  final String teks;
  final Color bgcolor;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: onpressed,
        child: Text(
          teks,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: bgcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
