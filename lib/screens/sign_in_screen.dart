import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innovabank/models/customer_model.dart';
import 'package:innovabank/screens/account_screen.dart';
import 'package:innovabank/services/customer_service.dart';

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
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: "TC Kimlik Numaranızı Giriniz",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      prefixIcon: const Icon(
                          Icons.person_2_outlined), // Arka plan rengi
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Yuvarlak köşeler
                        borderSide: BorderSide.none, // Kenarlık yok
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 20),
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    obscureText: true, // Şifreyi gizlemek için
                    decoration: InputDecoration(
                      hintText: "Şifre Giriniz",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      prefixIcon: const Icon(
                          Icons.lock_outline_rounded), // Arka plan rengi
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Yuvarlak köşeler
                        borderSide: BorderSide.none, // Kenarlık yok
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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
                    onPressed: () async {
                      try {
                        final CustomerService customerService =
                            CustomerService();
                        final Customer? customer =
                            await customerService.getCustomer("3");

                        if (customer != null) {
                          print(customer.name);
                        } else {
                          print("Müşteri bulunamadı.");
                        }
                      } catch (e) {
                        print("Hata: $e");
                      }
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AccountScreen(),

                      //   ),(route) => false);
                    },
                    child: const Text(
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
