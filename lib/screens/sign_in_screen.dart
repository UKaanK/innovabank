import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innovabank/screens/account_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Giris Yap",
          style: GoogleFonts.arvo(fontSize: 22, color: Colors.red),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: 400,
              height: 300,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: "TC Kimlik Numaranızı Giriniz",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      prefixIcon:
                          Icon(Icons.person_2_outlined), // Arka plan rengi
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Yuvarlak köşeler
                        borderSide: BorderSide.none, // Kenarlık yok
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 20),
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    obscureText: true, // Şifreyi gizlemek için
                    decoration: InputDecoration(
                      hintText: "Şifre Giriniz",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      prefixIcon:
                          Icon(Icons.lock_outline_rounded), // Arka plan rengi
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Yuvarlak köşeler
                        borderSide: BorderSide.none, // Kenarlık yok
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 60.0, // Buton yüksekliği
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Yuvarlak köşeler
                      ),
                    ),
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountScreen(),

                        ),(route) => false),
                    child: Text(
                      'Giriş Yap',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.red, // Beyaz yazı rengi
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
