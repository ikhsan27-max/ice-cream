import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KolomTeks extends StatelessWidget {
  const KolomTeks({
    super.key,
    required this.judul,
    required this.icon,
    required this.label,
    required this.hidepass,
  });

  final String judul;
  final IconData icon;
  final String label;
  final bool hidepass;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          // textAlign: TextAlign.start,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        TextField(
          obscureText: hidepass,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: Colors.pink),
            fillColor: Colors.pink,
            prefixIcon: Icon(icon),
            alignLabelWithHint: true,
            label: Text(label),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}
