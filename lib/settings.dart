import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'widgets/kolom_teks.dart';
import 'widgets/tombol.dart';

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
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Container(
              // height: 400,
              width: 500,
              decoration: BoxDecoration(
                color: const Color.fromARGB(62, 243, 115, 161),

                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
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
                      judul: 'Username',
                      icon: Icons.person,
                      label: 'Ganti Username Kamu',
                      hidepass: false,
                    ),
                    SizedBox(height: 24),
                    KolomTeks(
                      judul: 'Email',
                      icon: Icons.email,
                      label: 'Ganti Email Kamu',
                      hidepass: false,
                    ),
                    SizedBox(height: 24),

                    KolomTeks(
                      judul: 'Password',
                      icon: Icons.password,
                      label: 'Ganti Passsword Kamu',
                      hidepass: true,
                    ),
                    SizedBox(height: 24),

                    tombol(
                      teks: 'Selesai',
                      bgcolor: Colors.pink,
                      onpressed:
                          () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return GiffyDialog.image(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  243,
                                  115,
                                  161,
                                ),
                                Image.network(
                                  "https://media.tenor.com/oZoZ5XIereYAAAAi/cute-summer.gif",

                                  width: 498,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  'Info Disimpan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                content: Text(
                                  'Yeayy, Info Kamu berhasil disimpan, pencet OK untuk kembali',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, 'OK'),
                                    child: ClipOval(
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                255,
                                                243,
                                                115,
                                                161,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
