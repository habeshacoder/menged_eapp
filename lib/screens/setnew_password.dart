import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mengedegna_app/providers/auth.dart';
import 'package:mengedegna_app/screens/welcome_screen.dart';
import 'package:mengedegna_app/widgets/CButton.dart';
import 'package:provider/provider.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({required this.token});
  final dynamic token;

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  bool _obscureText = true;
  bool _obscureTextForConfirm = true;
  final passwordController = TextEditingController();
  final GlobalKey<FormState> passwordResetFormKey = GlobalKey();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleForConfirm() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Color(0xF0F9F8),
      elevation: 0.0,
      titleSpacing: 10.0,
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_rounded,
          color: Colors.black54,
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text('Set a New Password.')),
            Form(
              key: passwordResetFormKey,
              child: Column(
                children: [
                  //password
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      maxLines: 1,
                      // style: TextStyle(color: Colors.white),
                      style: TextStyle(color: Colors.black),

                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        suffixIcon: IconButton(
                            onPressed: _toggle,
                            icon: _obscureText
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        suffixIconColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 7),
                        filled: true,
                        fillColor: Colors.transparent,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        border: InputBorder.none,
                        hintText: 'New Password',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      obscureText: !_obscureText,
                      controller: passwordController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Password can't be  empty";
                        }
                        if (val.length < 4) {
                          return 'password length must be at least 4';
                        }
                        if (val.length > 8) {
                          return 'password length must not be greater than 8';
                        }
                        RegExp passwordRegex =
                            RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{4,8}$');
                        // RegExp regExp = new RegExp(pattern);
                        if (!passwordRegex.hasMatch(val)) {
                          return 'password must meet the requirements';
                        }
                        return null;
                      },
                      // onSaved: null,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      maxLines: 1,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        suffixIcon: IconButton(
                            onPressed: _toggle,
                            icon: _obscureTextForConfirm
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        suffixIconColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 7),
                        filled: true,
                        fillColor: Colors.transparent,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      obscureText: !_obscureTextForConfirm,
                      validator: (val) {
                        if (passwordController.text != val) {
                          return 'Password do not match';
                        }
                      },
                      onSaved: null,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CButton(
                    "Change Password",
                    onTap: () {
                      if (!passwordResetFormKey.currentState!.validate()) {
                        return;
                      }
                      setNewPassword(context, passwordController.text.trim());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void setNewPassword(BuildContext context, String useData) async {
    try {
      print('useData:..$useData');
      await Provider.of<Auth>(context, listen: false)
          .resetPassword(useData, widget.token);
    } on HttpException catch (error) {
      print(error);
      var errorMessage = 'faild to send code';
      showalert(errorMessage);
      return;
    } catch (error) {
      print('error:....$error');
      showalert('faild to verify the code');
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }

  //alert user for errors
  void showalert(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('an error occured'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('okay'),
            )
          ],
        );
      },
    );
  }
}
