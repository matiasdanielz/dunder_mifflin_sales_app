import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/pages/appIntro/appIntro.dart';
import 'package:flutter_application_5/pages/homepage/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 1),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SecondLoginPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppIntro();
  }
}

class SecondLoginPage extends StatefulWidget {
  @override
  _SecondLoginPageState createState() => _SecondLoginPageState();
}

class _SecondLoginPageState extends State<SecondLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool showErrorMessages = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 35.0,
            right: 35.0,
            top: 50,
          ),
          child: Form(
            autovalidateMode: showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140,
                  child: Image.asset(
                    'Assets/images/dunder_mifflin_logo.jpg',
                    width: double.infinity,
                  ),
                ),
                SizedBox(
                  height: 250,
                  width: 270,
                  child: Hero(
                    tag: 'subLogoHero',
                    child: Image.asset(
                      'Assets/images/sub_logo.jpeg',
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isEmailValid ? Colors.grey : Colors.red,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isEmailValid ? Colors.grey : Colors.red,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isEmailValid ? Colors.grey : Colors.red,
                        width: 1.5,
                      ),
                    ),
                    labelText: 'E-mail',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Segoe',
                    ),
                    errorText: (showErrorMessages && !isEmailValid)
                        ? 'Campo obrigatório'
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  showCursor: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isPasswordValid ? Colors.grey : Colors.red,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isPasswordValid ? Colors.grey : Colors.red,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isPasswordValid ? Colors.grey : Colors.red,
                        width: 1.5,
                      ),
                    ),
                    labelText: 'Senha',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Segoe',
                    ),
                    errorText: (showErrorMessages && !isPasswordValid)
                        ? 'Campo obrigatório'
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                  ),
                  onPressed: () => _loginButtonPressed(),
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: const Text(
                      "Acessar",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginButtonPressed() {
    setState(() {
      showErrorMessages = true;

      isEmailValid = emailController.text.isNotEmpty;
      isPasswordValid = passwordController.text.isNotEmpty;

      if (isEmailValid && isPasswordValid) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    });
  }
}
