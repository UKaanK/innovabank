import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Row(
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Text("InnovaBank",
                  style: GoogleFonts.arvo(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Hos geldiniz \nInnovaBank'a",
                style: GoogleFonts.arvo(fontSize: 40)),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 9),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              children: [
                Card(
                  elevation: 1,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: MediaQuery.of(context).size.height / 4,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_2_outlined,size: 70,color: Colors.red),
                        Text("Giriş Yap",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20),)
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  elevation: 1,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: MediaQuery.of(context).size.height / 4,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock_outline_sharp,size: 70,color: Colors.red),
                        Text("Şifremi Unuttum",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              children: [
                Card(
                  elevation: 1,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: MediaQuery.of(context).size.height / 4,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined,size: 70,color: Colors.red,),
                        Text("En Yakın ATM",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 1,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: MediaQuery.of(context).size.height / 4,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings_outlined,size: 70,color: Colors.red),
                        Text("Ayarlar",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
