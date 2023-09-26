import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:log_in_shared_preference/pages/home_page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  static const String id = "register";

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override

  void setEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailController.text.trim()).then((value) {
      log(value.toString());
      Navigator.pushReplacementNamed(context, HomePage.id);
    });
  }
  void getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email') ?? "";
    if (savedEmail.isEmpty) {

    } else {
      setState(() {
        email = savedEmail;
      });
    }
    log(savedEmail);
  }
  void initState() {
    // TODO: implement initState
getEmail();
    super.initState();
  }
  String email = "";
  String name = "";
  String password = "";
 TextEditingController emailController=TextEditingController();
 TextEditingController nameController=TextEditingController();
 TextEditingController passwordController=TextEditingController();
 @override



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding:const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Register now",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  TextField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  decoration:const InputDecoration(
                      hintText: "Enter your name",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  TextField(
                  controller:emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      hintText: "Enter your email",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      hintText: "Enter your password",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none),
                ),
              ),
              TextButton(
                onPressed :setEmail,
                child: const Text(
                  "Log In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
