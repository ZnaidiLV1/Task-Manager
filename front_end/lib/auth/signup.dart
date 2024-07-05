import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_front/auth/login.dart';
import 'package:task_manager_front/bloc/client_singleton.dart';
import 'package:task_manager_front/shortcuts/text_field.dart';
import 'package:task_manager_front/ui/home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String emailField = "";
  String passwordField = "";
  String first_name_field = "";
  String last_name_field = "";
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
                    "Sign Up",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                    "Create your account",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                  text: 'First Name',
                  icon: Icons.person,
                  onChanged: (String value) {
                    first_name_field = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  obscure: false,
                ),
                FormFieldWidget(
                  text: 'Last Name',
                  icon: Icons.person,
                  onChanged: (String value) {
                    last_name_field = value;
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
                      Uri creation_uri =
                          Uri.parse("http://10.0.2.2:8000/auth/create_user/");
                      Response creation_response = await HttpClientManager
                          .client
                          .post(creation_uri, body: {
                        "email": emailField,
                        "first_name": first_name_field,
                        "last_name": last_name_field,
                        "password": passwordField
                      });
                      if (creation_response.statusCode == 200) {
                        Uri login_uri =
                            Uri.parse("http://10.0.2.2:8000/auth/login/");
                        Response login_response = await HttpClientManager.client
                            .post(login_uri, body: {
                          "email": emailField,
                          "password": passwordField
                        });
                        Map<String, dynamic> data = json.decode(login_response.body);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => 
                          HomePage(refresh_token: data["refresh"],)));
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.11),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      child: const Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 85),
                            child: Text(
                              "Already  have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF9C29B2)),
                          ),
                        ],
                      )),
                ),
              ],
            )),
      ),
    );
  }
}
