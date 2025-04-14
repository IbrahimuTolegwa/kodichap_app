import 'package:flutter/material.dart';

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final username = usernameController.text;
  // final password = passwordController.text;
  // final email = emailController.text;

  registrationMethod(String userName, String email, String password){

  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
