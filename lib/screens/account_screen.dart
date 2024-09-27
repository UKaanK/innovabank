import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Hesaplarım ",
          style: GoogleFonts.arvo(fontSize: 22, color: Colors.red),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Card(
                elevation: 1,
                color: Colors.white,
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "IB",
                              style: GoogleFonts.arvo(
                                  fontSize: 22,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Vadesiz Hesap",
                              style: GoogleFonts.arvo(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 30,),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text("5067 5687 9851 5632",style: TextStyle(fontSize: 11),textAlign: TextAlign.right,),
                            )
                          ],
                        ),
                        Text(
                          "56,547.00 £",
                          style: GoogleFonts.arvo(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Card(
                elevation: 1,
                color: Colors.white,
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "IB",
                              style: GoogleFonts.arvo(
                                  fontSize: 22,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Kredi Kartı",
                              style: GoogleFonts.arvo(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 30,),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text("5067 5687 9851 5632",style: TextStyle(fontSize: 11),textAlign: TextAlign.end,),
                            )
                          ],
                        ),
                        Text(
                          "56,547.00 £",
                          style: GoogleFonts.arvo(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white70,
        width: 185,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              TextButton(onPressed: () {
                
              },child: Text("Profil" ,style: GoogleFonts.arvo(
                      fontSize: 22, fontWeight: FontWeight.bold,color:Colors.black))),
             TextButton(onPressed: () {
                
              },child: Text("Çıkıs Yap" ,style: GoogleFonts.arvo(
                      fontSize: 22, fontWeight: FontWeight.bold,color:Colors.black))),
            ],
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 1,
         iconSize: 35.0, // İkon boyutunu büyütmek için
         unselectedFontSize: 15,
         selectedFontSize: 15,
         currentIndex: 0,
        items: [
        BottomNavigationBarItem(
            label: "Hesaplar", icon: Icon(Icons.account_balance_wallet_outlined,color: Colors.red,)),
        BottomNavigationBarItem(
            label: "Ödemeler", icon: Icon(Icons.wallet_rounded,color: Colors.red    )),
        BottomNavigationBarItem(
            label: "Transferler", icon: Icon(Icons.spatial_tracking_outlined,color: Colors.red)),
      ]),
    );
  }
}
