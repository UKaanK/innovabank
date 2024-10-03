import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innovabank/models/customer_model.dart';
import 'package:innovabank/screens/account_screen.dart';
import 'package:innovabank/screens/sign_up_screen.dart';
import 'package:innovabank/services/customer_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _tcController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                    controller: _tcController,
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
                    controller: _passwordController,
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
                Container(
                  padding: const EdgeInsets.only(right: 40, bottom: 20),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        )),
                    child: Text("Hesabınız Yok Mu ?",
                        style:
                            GoogleFonts.arvo(fontSize: 15, color: Colors.red)),
                  ),
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
                      String enteredTC = _tcController.text.trim();
                      String enteredPassword = _passwordController.text.trim();
                      try {
                        final CustomerService customerService =
                            CustomerService();
                        final Customer? customer =
                            await customerService.getCustomer(enteredTC);

                        if (customer != null) {
                          // Şifreyi kontrol et
                          if (customer.password == enteredPassword) {
                            // Örnek: Şifreyi phoneNumber ile kontrol ediyoruz
                            print("Giriş başarılı: ${customer.email}");
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AccountScreen(customer: customer),
                              ),
                              (route) => false,
                            );
                          } else {
                            print("Hatalı şifre.");
                          }
                        } else {
                          print("Müşteri bulunamadı.");
                        }
                      } catch (e) {
                        print("Hata: $e");
                      }
                    },
                    child: Text('Giris Yap',
                        style:
                            GoogleFonts.arvo(fontSize: 18, color: Colors.red)),
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
