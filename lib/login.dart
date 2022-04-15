import 'dart:convert';
import 'dart:js_util';

import 'package:demo/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final emailctrl = TextEditingController();
  final passwordctrl = TextEditingController();
  var email = "";
  var password = "";
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Color(0xffd2456d),
    minimumSize: Size(150, 50),
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  savedata(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<User> userlist = [];
    final String? userStr = prefs.getString('user');
    if (userStr != null) {
      List<dynamic> datalist = [];
      datalist = jsonDecode(userStr);
      Map<String, dynamic> userMap = {};
      datalist.map((userMapdata) {
        User user = User.fromJson(userMapdata);
        userlist.add(User(email: user.email, password: user.password));
      }).toList();
      userlist.add(User(email: email, password: password));
    } else {
      userlist.add(User(email: email, password: password));
    }
    String json = jsonEncode(userlist);
    prefs.setString('user', json);
  }

  read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = {};
    List<dynamic> list = [];
    final String? userStr = prefs.getString('user');
    if (userStr != null) {
      list = jsonDecode(userStr);
    }
    list.map((userMapdata) {
      User user = User.fromJson(userMapdata);
    }).toList();
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Form(
              key: _formkey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(fontSize: 13.0, color: Colors.black),
                      border: OutlineInputBorder(),
                      focusColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      )),
                  controller: emailctrl,
                  focusNode: _focusEmail,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle:
                          TextStyle(fontSize: 13.0, color: Colors.black),
                      border: OutlineInputBorder(),
                      focusColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      )),
                  focusNode: _focusPassword,
                  obscureText: true,
                  controller: passwordctrl,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    savedata(emailctrl.text, passwordctrl.text);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Homepage()));
                  },
                  child: Text("Login"),
                  style: raisedButtonStyle,
                ),
                ElevatedButton(
                  onPressed: read,
                  child: Text("read"),
                  style: raisedButtonStyle,
                ),
                ElevatedButton(
                  onPressed: clear,
                  child: Text("clear"),
                  style: raisedButtonStyle,
                ),
                ElevatedButton(
                  onPressed: () {
                    _focusEmail.unfocus();
                    _focusPassword.unfocus();

                    if (_formkey.currentState!.validate()) {}
                  },
                  child: Text("Signup"),
                  style: raisedButtonStyle,
                )
              ]))
        ]),
      ),
    );
  }
}
