import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:log_in_shared_preference/pages/home_page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockScreen extends StatefulWidget {
  static const String id = "lock_screen";

  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  String enteredPin = '1234';
  bool pinIsVisible = false;
  bool isFirstTimeEntered = true;
  TextEditingController passwordController = TextEditingController();

  void setPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pin', passwordController.text.trim()).then((value) {
      log(value.toString());
      Navigator.pushReplacementNamed(context, HomePage.id);
    });
  }

  void getPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedPin = prefs.getString('enteredPin') ?? "";
    if (savedPin.isEmpty) {
      setState(() {
        isFirstTimeEntered = true;
      });
    } else {
      setState(() {
        enteredPin = savedPin;
      });
    }
    log(savedPin);
  }

  void onChanged(String text) {
    if (text == enteredPin) {
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else if (text.length == 4 && text != enteredPin) {
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

  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (enteredPin.length < 4) {
              enteredPin += number.toString();
            }
          });
        },
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 70,
            ),
            const Center(
              child: Text(
                "Enter your password",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 50,
            ),

            /// pin cod area
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.all(6),
                  height: pinIsVisible ? 50 : 20,
                  width: pinIsVisible ? 50 : 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black54),
                  child: pinIsVisible && index < enteredPin.length
                      ? Center(
                          child: Text(
                            enteredPin[index],
                            style: const TextStyle(
                                fontSize: 17,
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : null,
                );
              }),
            ),

            /// visibiltiy button
            IconButton(
              onPressed: () {
                setState(() {
                  pinIsVisible = !pinIsVisible;
                });
              },
              icon: Icon(
                pinIsVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: pinIsVisible ? 50 : 8,
            ),

            /// raqamlar
            for (var i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                    (index) => numButton(1 + 3 * i + index),
                  ).toList(),
                ),
              ),

            /// 0 va backspace
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Container(
                     margin: const EdgeInsets.only(left: 10),
                     child: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.done,color: Colors.white,size: 30,),
                  ),
                   ),
                  numButton(0),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (enteredPin.isNotEmpty) {
                            enteredPin =
                                enteredPin.substring(0, enteredPin.length - 1);
                          }
                        });
                      },
                      child: const Icon(
                        Icons.backspace,
                        size: 26,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// reset
            TextButton(
              onPressed: () {
                setState(() {
                  enteredPin = '';
                });
              },
              child: const Text(
                "Reset",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
