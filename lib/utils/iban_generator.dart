import 'dart:math';

String generateIban() {
  // Türkiye için sabit ülke kodu ve iki basamaklı kontrol numarası
  String countryCode = "TR";

  // 5 haneli banka kodu (örneğin 12345)
  String bankCode = Random().nextInt(100000).toString().padLeft(5, '0');

  // 16 haneli hesap numarası oluşturma
  String accountNumber = "";
  for (int i = 0; i < 16; i++) {
    accountNumber += Random().nextInt(10).toString();
  }

  // Tam IBAN
  String iban = "$countryCode${17}$bankCode$accountNumber";
  return iban;
}
