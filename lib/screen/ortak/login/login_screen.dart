import 'package:flutter/material.dart';

import 'login_background.dart';
import 'login_widget.dart';

class LoginP extends StatefulWidget {
  const LoginP({super.key});

  @override
  State<LoginP> createState() => _LoginPState();
}

class _LoginPState extends State<LoginP> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        Background(),
        LoginForm(),
      ],
    ));
  }
}
