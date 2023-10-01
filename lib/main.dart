import 'package:flutter/material.dart';
import 'package:log_in_shared_preference/pages/home_page/home_page.dart';
import 'package:log_in_shared_preference/pages/home_page/register.dart';
import 'package:log_in_shared_preference/pages/pin_code_page/pincodepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Register(),
      routes: {
        HomePage.id:(context)=>const HomePage(),
        Register.id:(context)=>const Register(),
        PinCodePage.id:(context)=>const PinCodePage(),
      },
    );
  }
}


