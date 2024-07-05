// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:task_manager_front/auth/signup.dart';
import 'package:task_manager_front/bloc/client_singleton.dart';
import 'package:task_manager_front/shortcuts/text_field.dart';
import 'package:task_manager_front/ui/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String emailField = "";
  String passwordField = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.07),
                child: Text(
                  "Welcome",
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.07),
                child: Text(
                  "Enter your credential to login",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              FormFieldWidget(
                text: 'Email',
                icon: Icons.email,
                onChanged: (String value) {
                  emailField = value;
                },
                keyboardType: TextInputType.emailAddress,
                obscure: false,
              ),
              FormFieldWidget(
                text: 'Password',
                icon: Icons.password,
                onChanged: (String value) {
                  passwordField = value;
                },
                keyboardType: TextInputType.text,
                obscure: true,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.86,
                decoration: BoxDecoration(
                    color: Color(0xFF9C29B2),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: MaterialButton(
                  onPressed: () async {
                    Uri login_uri =
                        Uri.parse("http://10.0.2.2:8000/auth/login/");
                    final login_response = await HttpClientManager.client
                        .post(login_uri, body: {"email": "amine@gmail.com",
                        "password":"Znaidi 2002"});
                    if (login_response.statusCode == 200) {
                      Map<String, dynamic> data =
                          json.decode(login_response.body);
                      String refresh_token = data["refresh"];
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => 
                          HomePage(refresh_token: refresh_token,)));
                    } else {
                      showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Authentication Error"),
                      content: const Text(
                          "Incorrect email or password. Please try again."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.11),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Color(0xFF9C29B2)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.11),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 85),
                          child: Text(
                            "Dont have an account?",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF9C29B2)),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
