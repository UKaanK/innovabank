import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innovabank/models/account_model.dart';
import 'package:innovabank/models/customer_model.dart';
import 'package:innovabank/screens/account_add_screen.dart';
import 'package:innovabank/screens/main_screen.dart';
import 'package:innovabank/screens/transfer_screen.dart';
import 'package:innovabank/services/account_service.dart';

class AccountScreen extends StatefulWidget {
  final Account? account;
  final Customer customer;
  const AccountScreen({super.key, required this.customer, this.account});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AccountService _accountService = AccountService();
  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth örneği
  List<Map<String, dynamic>> _accounts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    _accounts = await _accountService.getAccounts(widget.customer.customerId);
    setState(() {
      _isLoading = false;
    });
  }

   // Çıkış onayı penceresi
  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Çıkış Yap'),
          content: const Text('Çıkış yapmak istediğinize emin misiniz?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialogdan çık
              },
              child: const Text('Hayır'),
            ),
            TextButton(
              onPressed: () {
                _signOut(); // Çıkış yap
                Navigator.of(context).pop(); // Dialogdan çık
              },
              child: const Text('Evet'),
            ),
          ],
        );
      },
    );
  }

    // Kullanıcı çıkış yapma fonksiyonu
  Future<void> _signOut() async {
    await _auth.signOut(); // Firebase'den çıkış yap
    // Çıkış işleminden sonra yapılacak işlemler (örn. anasayfaya yönlendirme)
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainScreen(),), (route) => false);// Giriş sayfasına yönlendir
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Hesaplarım",
          style: GoogleFonts.arvo(fontSize: 22, color: Colors.red),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _accounts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hesap bulunamadı.",
                        style: GoogleFonts.arvo(fontSize: 22, color: Colors.black),
                      ),
                      TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AccounAddScreen(customer:widget.customer),)) , child: Text("Hesap Açmak Ister misiniz ? ",style: GoogleFonts.arvo(fontSize: 15, color: Colors.red,fontWeight:FontWeight.bold)))
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _accounts.length,
                  itemBuilder: (context, index) {
                    var account = _accounts[index];
                    return Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
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
                                    const SizedBox(width: 5),
                                    Text(
                                      account['accountType'],
                                      style: GoogleFonts.arvo(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 30),
                                    Padding(
                                      padding: const EdgeInsets.only(left:30,top: 8.0),
                                      child: Text(
                                        account['iban'],
                                        style: const TextStyle(fontSize: 11),
                                        textAlign: TextAlign.end,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "${account['balance']} £",
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
                    );
                  },
                ),
      endDrawer: Drawer(
        backgroundColor: Colors.white70,
        width: 185,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            TextButton(
              onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => AccounAddScreen(customer: widget.customer),)),
              child: Text(
                "Hesap Ekle",
                style: GoogleFonts.arvo(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
               return _showSignOutDialog(); // Çıkış onay penceresini göster
              },
              child: Text(
                "Çıkıs Yap",
                style: GoogleFonts.arvo(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value==1) {
            ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.grey[200],
                      elevation: 0,
                      content: Text("Yapım Aşamasında",textAlign: TextAlign.center,style: TextStyle(color:Colors.red),),
                      duration: Duration(seconds: 3),
                    ));
          }
          if (value==2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TransferScreen(account: _accounts,),));
          }
          print(value);
          
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 1,
        iconSize: 35.0,
        unselectedFontSize: 15,
        selectedFontSize: 15,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
              label: "Hesaplar",
              icon: Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.red,
              )),
          BottomNavigationBarItem(
              label: "Ödemeler",
              icon: Icon(
                Icons.wallet_rounded,
                color: Colors.red,
              )),
          BottomNavigationBarItem(
              label: "Transferler",
              icon: Icon(
                Icons.spatial_tracking_outlined,
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}
