import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/kolom_teks.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/banner.jpeg'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.pink,
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(200 / 2),
                  ),

                  height: 120,
                  width: 120,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pinkAccent,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.camera_enhance,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              KolomTeks(
                judul: 'Email',
                icon: Icons.email,
                label: 'Ganti Email Kamu',
              ),
              SizedBox(height: 24),

              KolomTeks(
                judul: 'Password',
                icon: Icons.password,
                label: 'Ganti Passsword Kamu',
              ),
              SizedBox(height: 24),

              KolomTeks(
                judul: 'Verifikasi Password',
                icon: Icons.password_rounded,
                label: 'Verifikasi Password Kamu',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


