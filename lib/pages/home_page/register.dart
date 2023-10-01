import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:log_in_shared_preference/pages/models/user_models.dart';
import 'package:log_in_shared_preference/pages/pin_code_page/pincodepage.dart';
import 'package:log_in_shared_preference/pages/services/shared_prefers.dart';

class Register extends StatefulWidget {
  static const String id = "register";

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

TextEditingController nameController = TextEditingController();

class _RegisterState extends State<Register> {
  UserModel? userModel;
  bool isFirstTimeEntered = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final routeController=TextEditingController();

  @override
  void saveUserData() async {
    UserModel userModel = UserModel(
      route:Navigator.pushReplacementNamed(context, PinCodePage.id).toString(),
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    SharedPrefsServices services = SharedPrefsServices();
    services.addToLocal(userModel);
    log("Saved!");
  }

  void getUserData() async {
    SharedPrefsServices services = SharedPrefsServices();
    final userData = await services.getFromLocal();
    if (userData != null) {
      setState(() {
        userModel = userData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: userModel == null
            ? Padding(
                padding: const EdgeInsets.all(20),
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
                      child: TextField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
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
                      child: TextField(
                        controller: emailController,
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
                      onPressed:saveUserData,
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
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(userModel!.name),
                  Text(userModel!.email),
                  Text(userModel!.password),
                  Text(userModel!.route),
                ],
              ),
      ),
    );
  }
}
