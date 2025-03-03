import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_booking/widgets/color.dart';

class KolomTeks extends StatelessWidget {
  const KolomTeks({
    super.key,
    required this.judul,
    required this.icon,
    required this.label,
    this.suffixIcon,
    required this.isHidden,
  });

  final String judul;
  final IconData icon;
  final String label;
  final bool isHidden;
  final IconButton? suffixIcon;

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
          obscureText: isHidden,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: MyColor.primary),
            fillColor: MyColor.primary,
            suffixIcon: suffixIcon,
            alignLabelWithHint: true,
            label: Text(label),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColor.primary),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}
