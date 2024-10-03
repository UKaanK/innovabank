import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innovabank/models/account_model.dart';
import 'package:innovabank/models/transaction_model.dart';
import 'package:innovabank/services/transfer_service.dart';

class TransferScreen extends StatefulWidget {
  final List<Map<String, dynamic>> account;
  const TransferScreen({super.key, required this.account});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _recipientIbanController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedAccount;
  late Map<String, String> _accounts;

  @override
  void initState() {
    super.initState();

    _accounts = {};
    for (var acc in widget.account) {
      String accountType = acc['accountType'] ?? 'Hesap Bilinmiyor';
      String iban = acc['iban'] ?? 'TR000000000000000000000000';
      _accounts[accountType] = iban;
    }

    setState(() {
      // Force UI update after initializing data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Para Transferi",
            style: GoogleFonts.arvo(fontSize: 22, color: Colors.red)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Gönderen Hesap",
                  style: GoogleFonts.arvo(
                      fontSize: 16, fontWeight: FontWeight.bold)),
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
                items: _accounts.keys
                    .map<DropdownMenuItem<String>>((String account) {
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
              Text("IBAN Bilgisi",
                  style: GoogleFonts.arvo(
                      fontSize: 16, fontWeight: FontWeight.bold)),
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
              Text("Transfer Miktarı",
                  style: GoogleFonts.arvo(
                      fontSize: 16, fontWeight: FontWeight.bold)),
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
              Text("Kullanıcının Adı Soyadı",
                  style: GoogleFonts.arvo(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: _recipientNameController,
                decoration: InputDecoration(
                  hintText: "Kullanıcının Adı Soyadı",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text("Kullanıcının IBAN bilgisi",
                  style: GoogleFonts.arvo(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: _recipientIbanController,
                decoration: InputDecoration(
                  hintText: "IBAN",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text("Açıklama Giriniz",
                  style: GoogleFonts.arvo(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "Açıklama Giriniz",
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
                  onPressed: _performTransfer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.red,
                  ),
                  child: Text("Gönder",
                      style:
                          GoogleFonts.arvo(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performTransfer() {
    String fromAccountId = _selectedAccount!; // Kullanıcı seçtiği hesap ID
    String toAccountIban = _recipientIbanController.text;
    double? amount = double.tryParse(_amountController.text);
    String recipientName = _recipientNameController.text;
    String description = _descriptionController.text;

    if (fromAccountId.isEmpty ||
        toAccountIban.isEmpty ||
        amount == null ||
        recipientName.isEmpty ||
        description.isEmpty) {
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
      // Transaction oluştur
      TransactionModel newTransaction = TransactionModel(
        fromAccountId: fromAccountId,
        toAccountIban: toAccountIban,
        amount: amount,
        transactionType: 'Transfer',
        timestamp: DateTime.now(),
        description: description,
        recipientName: recipientName,
      );

      // Firestore'a kaydet
      FirestoreTransactionService().addTransaction(newTransaction).then((_) {
        // Başarı mesajı
        _showSuccessMessage();
      }).catchError((error) {
        // Hata mesajı
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Hata"),
              content: Text("İşlem sırasında bir hata oluştu: $error"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Tamam"),
                ),
              ],
            );
          },
        );
      });
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
