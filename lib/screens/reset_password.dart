import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mengedegna_app/providers/auth.dart';
import 'package:mengedegna_app/screens/confirm_mail.dart';
import 'package:mengedegna_app/widgets/CButton.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final Map<String, dynamic> sendCodeToEmail = {
    "email": "",
  };
  final passwordController = TextEditingController();
  final GlobalKey<FormState> passwordResetFormKey = GlobalKey();

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
            Text(
              'Reset Password',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Have you forgotten your password? We will send the confirmation code to your email address.',
              style: TextStyle(fontSize: 12),
              softWrap: true,
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Form(
                key: passwordResetFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.person),
                        suffixIconColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 7),
                        filled: true,
                        fillColor: Colors.white60,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0),
                        ),
                        // focusColor: Colors.grey,
                        // labelText: 'Full Name',
                        hintText: 'E-Mail',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' email can not be embty';
                        }
                        if (!value.contains('@')) {
                          return 'please, enter valid email';
                        }
                        return null;
                      },
                      controller: passwordController,
                      onSaved: (value) {
                        sendCodeToEmail["email"] = passwordController.text;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            CButton(
              "Send Code",
              onTap: () {
                if (!passwordResetFormKey.currentState!.validate()) {
                  return;
                }

                sendCodeForPasswordReset(context);
                passwordResetFormKey.currentState!.save();
              },
            ),
          ],
        ),
      ),
    );
  }

  void sendCodeForPasswordReset(BuildContext context) async {
    try {
      //store email locally
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String emailData = sendCodeToEmail["email"].toString();
      await prefs.setString('email', emailData);

      print('email data:..$sendCodeToEmail');
      await Provider.of<Auth>(context, listen: false)
          .sendCodeForPasswordReset(sendCodeToEmail);
    } on HttpException catch (error) {
      print(error);
      var errorMessage = 'faild to send code';
      showalert(errorMessage);
      return;
    } catch (error) {
      print('error:....$error');
      showalert('$error');
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ConfirmEmail(sendCodeToEmailData: sendCodeToEmail),
        // CodeEntryScreen(),
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
