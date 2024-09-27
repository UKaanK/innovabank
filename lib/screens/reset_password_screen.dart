import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sifremi Unuttum",
          style: GoogleFonts.arvo(fontSize: 22, color: Colors.red),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text("Lütfen TC Kimlik Numaranızı Giriniz",style: GoogleFonts.arvo(
                        fontSize: 50, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 50,),
             Column(
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
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("yapım aşamasında",textAlign: TextAlign.center,),duration: Duration(seconds: 3),)),
                      child: Text(
                        'Gönder',
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