import 'package:cloud_firestore/cloud_firestore.dart';
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
                maxLength: 25,
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

Future<void> _performTransfer() async {
  String fromAccountType = _selectedAccount!; // Kullanıcı seçtiği hesap tipi
  String toAccountIban = _recipientIbanController.text;
  double? amount = double.tryParse(_amountController.text);
  String recipientName = _recipientNameController.text;
  String description = _descriptionController.text;

  if (fromAccountType.isEmpty ||
      toAccountIban.isEmpty ||
      amount == null ||
      recipientName.isEmpty ||
      description.isEmpty) {
    _showErrorMessage("Lütfen tüm alanları doldurun.");
    return;
  }

  if (toAccountIban.length < 25) {
    _showErrorMessage("İban Bilgisini Eksiksiz ve Doğru Giriniz");
    return;
  }

  try {
    // Gönderen hesap `accountType`'e göre bulunuyor
    QuerySnapshot fromAccountSnapshot = await FirebaseFirestore.instance
        .collection('accounts')
        .where('accountType', isEqualTo: fromAccountType)
        .get();

    if (fromAccountSnapshot.docs.isEmpty) {
      throw Exception("Gönderen hesap bulunamadı.");
    }

    // Alıcı hesabı IBAN ile kontrol edin
    QuerySnapshot toAccountSnapshot = await FirebaseFirestore.instance
        .collection('accounts')
        .where('iban', isEqualTo: toAccountIban)
        .get();

    if (toAccountSnapshot.docs.isEmpty) {
      throw Exception("Alıcı hesap bulunamadı.");
    }

    // Alıcı hesabının customerId'sini al
    String recipientCustomerId = toAccountSnapshot.docs.first.get('customerId');

    // Alıcıya ait müşteri bilgilerini kontrol et
    QuerySnapshot customerSnapshot = await FirebaseFirestore.instance
        .collection('customers')
        .where('customerId', isEqualTo: recipientCustomerId)
        .get();

    // Müşteri bilgisi var mı kontrol et
    if (customerSnapshot.docs.isNotEmpty) {
      var customerDoc = customerSnapshot.docs.first; // İlk müşteri dokümanı
      String customerName = customerDoc.get('name'); // Müşteri adını al
      
      // Alıcı adı ile karşılaştırma
      if (customerName.trim().toLowerCase() != recipientName.trim().toLowerCase()) {
        throw Exception("Girilen alıcı adı ile IBAN eşleşmiyor.");
      }
    } else {
      throw Exception("Müşteri bilgisi bulunamadı.");
    }

    // Transaction işlemi burada yapılır
    await FirestoreTransactionService().performTransaction(
      fromAccountId: fromAccountSnapshot.docs.first.id,
      toAccountIban: toAccountIban,
      amount: amount,
      recipientName: recipientName,
      description: description,
    );

    // Başarı mesajı
    _showSuccessMessage();
  } catch (e) {
    // Hata mesajı
    _showErrorMessage("İşlem sırasında bir hata oluştu: ${e.toString()}");
  }
}


void _showErrorMessage(String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Hata"),
        content: Text(message),
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
