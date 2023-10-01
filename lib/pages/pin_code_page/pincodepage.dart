import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:log_in_shared_preference/pages/home_page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinCodePage extends StatefulWidget {
  static const String id = "pin_page";

  const PinCodePage({super.key});

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  bool isFirstTimeEntered = false;
  String pin = "";
  final TextEditingController controller = TextEditingController();

  void setPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pin', controller.text.trim()).then((value) {
      log(value.toString());
      Navigator.pushReplacementNamed(context, PinCodePage.id);
    });
  }

  void getPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedPin = prefs.getString('pin') ?? "";
    if (savedPin.isEmpty) {
      setState(() {
        isFirstTimeEntered = true;
      });
    } else {
      setState(() {
        pin = savedPin;
      });
    }
    log(savedPin);
  }

  void onChanged(String text) {
    if (text == pin) {
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else if (text.length == 4 && text != pin) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            title: Text("Pin Code Xato"),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getPin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              constraints: const BoxConstraints(
                maxWidth: 240,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controller,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                    border:InputBorder.none,
                    hintText: "Enter PIN-Code"),
                onChanged: (String text) {
                  onChanged(text);
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (isFirstTimeEntered)
            ElevatedButton(
              onPressed: setPin,
              child: const Text("Set PIN"),
            ),
        ],
      ),
    );
  }
}