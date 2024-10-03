import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innovabank/models/account_model.dart';

class TransferScreen extends StatefulWidget {
 final List<Map<String, dynamic>> account;
  const TransferScreen({super.key, required this.account});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _selectedAccount;
  late Map<String, String> _accounts;

  @override
  void initState() {
    super.initState();
    // Hesapları burada başlatıyoruz ve widget.account bilgisiyle dolduruyoruz.
    _accounts = {
    };
    for (var acc in widget.account) {
      // Hesap türü ve IBAN'ı map içine ekliyoruz
      String accountType = acc['accountType'] ?? 'Hesap Bilinmiyor';
      String iban = acc['iban'] ?? 'TR000000000000000000000000';
      _accounts[accountType] = iban;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Para Transferi", style: GoogleFonts.arvo(fontSize: 22, color: Colors.red)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Gönderen Hesap", style: GoogleFonts.arvo(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedAccount,
              hint: Text("Hesap Seçiniz"),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAccount = newValue;
                  _ibanController.text = _accounts[newValue!]!;
                });
              },
              items: _accounts.keys.map<DropdownMenuItem<String>>((String account) {
                return DropdownMenuItem<String>(
                  value: account,
                  child: Text(account),
                );
              }).toList(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("IBAN Bilgisi", style: GoogleFonts.arvo(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _ibanController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "IBAN Otomatik Doldurulacak",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Transfer Miktarı", style: GoogleFonts.arvo(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Miktar",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _performTransfer();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.red,
                ),
                child: Text("Gönder", style: GoogleFonts.arvo(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performTransfer() {
    String iban = _ibanController.text;
    double? amount = double.tryParse(_amountController.text);
    String? selectedAccount = _selectedAccount;

    if (selectedAccount == null || iban.isEmpty || amount == null) {
      // Hata mesajı göster
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Hata"),
            content: Text("Lütfen tüm alanları doldurun."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Tamam"),
              ),
            ],
          );
        },
      );
    } else {
      // Transfer işlemi gerçekleştirme
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Onay"),
            content: Text("Transfer işlemini onaylıyor musunuz?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // İşlemi iptal et
                child: Text("Hayır"),
              ),
              TextButton(
                onPressed: () {
                  // Transfer işlemi başarılı
                  Navigator.pop(context);
                  _showSuccessMessage();
                },
                child: Text("Evet"),
              ),
            ],
          );
        },
      );
    }
  }

  void _showSuccessMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Başarılı"),
          content: Text("Transfer başarıyla gerçekleştirildi."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }
}
