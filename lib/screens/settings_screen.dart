import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          "Ayarlar",
          style: GoogleFonts.arvo(fontSize: 22, color: Colors.red),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12)
          ),
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
          margin: EdgeInsets.only(left: 25,right:25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //dark mode
              Text("Karanlık Mod",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red
              ),),
          
              //switch toggle
              CupertinoSwitch(value: true,
              onChanged: (value) {
                value=false;
              },
              )
            ],
          ),
        ),
      ),
    );
  }
}