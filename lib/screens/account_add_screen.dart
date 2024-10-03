import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innovabank/models/customer_model.dart';
import 'package:innovabank/services/account_service.dart';

class AccounAddScreen extends StatefulWidget {
  final Customer customer;

  const AccounAddScreen({super.key, required this.customer});

  @override
  State<AccounAddScreen> createState() => _AccounAddScreenState();
}

class _AccounAddScreenState extends State<AccounAddScreen> {
    final AccountService _accountService = AccountService();
  String? _selectedAccountType;
  final TextEditingController _balanceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hesap Ekle",
          style: GoogleFonts.arvo(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ), // Arka plan rengi,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomRadioButton(
            buttonLables: [
              "Vadeli",
              "Vadesiz",
            ],
            buttonValues: [
              "Vadeli",
              "Vadesiz",
            ],
            radioButtonValue: (values) {
              setState(() {
                _selectedAccountType = values; // Seçilen değeri kaydet
              });
            },
            horizontal: false,
            width: 200,
            elevation: 0,
            enableShape: true,
            padding: 5,
            selectedColor: Colors.red,
            unSelectedColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Bakiyenizi Giriniz:",
                    style: GoogleFonts.arvo(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red)),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.8,
                  height: 35,
                  child: TextField(
                    controller: _balanceController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 13),
                      hintText: "Bakiyenizi Giriniz",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Yuvarlak köşeler
                        borderSide: BorderSide.none, // Kenarlık yok
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (_selectedAccountType != null &&
                    _balanceController.text.isNotEmpty) {

                  // Hesap türü ve bakiye bilgileri mevcutsa hesap oluşturma işlemini yapın
                  print("Hesap Türü: $_selectedAccountType");
                  print("Bakiye: ${_balanceController.text}");
                  // Hesap oluşturma işlemi için backend servisi çağrılabilir.
                  _accountService.addAccount(widget.customer.customerId, _selectedAccountType!, double.parse(_balanceController.text));
                  Navigator.pop(context,true);
                } else {
                  // Uyarı ver
                  print("Lütfen tüm bilgileri doldurun.");
                }
              },
              child: Text("Hesap Olustur",
                  style: GoogleFonts.arvo(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.red)))
        ],
      ),
    );
  }
}
