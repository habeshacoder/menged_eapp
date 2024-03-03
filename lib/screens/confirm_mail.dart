import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mengedegna_app/providers/auth.dart';
import 'package:mengedegna_app/screens/setnew_password.dart';
import 'package:mengedegna_app/widgets/CButton.dart';
import 'package:provider/provider.dart';

class ConfirmEmail extends StatefulWidget {
  static final routeName = 'ConfirmEmail';
  Map<String, dynamic> sendCodeToEmailData;
  ConfirmEmail({required this.sendCodeToEmailData});

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  List<String> codeDigits = List.filled(6, '');

  void ResendCodeForPasswordReset(BuildContext context) async {
    try {
      await Provider.of<Auth>(context, listen: false)
          .sendCodeForPasswordReset(widget.sendCodeToEmailData);
    } on HttpException catch (error) {
      print(error);
      var errorMessage = 'faild to send code';
      showalert(errorMessage);
    } catch (error) {
      print(error);
      showalert('$error');
    }
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
              'Confirmation',
              style: TextStyle(fontSize: 32),
            ),
            Text(
              'Enter the code that we sent to your email',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 25),
            _buildCodeInputFields(),
            SizedBox(height: 25),
            CButton(
              "Verify Code",
              onTap: () {
                String enteredCode = codeDigits.join('');
                _verifyCode(context, enteredCode);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        6,
        (index) => SizedBox(
          height: 50,
          width: 40.0,
          child: TextField(
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                codeDigits[index] = value;
              });
              if (value.length == 1 && index < 5) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
            },
          ),
        ),
      ),
    );
  }

  void _verifyCode(BuildContext context, dynamic enteredCode) async {
    // try {
    //   print('code:..$enteredCode');
    //   await Provider.of<Auth>(context, listen: false)
    //       .verifyPasswordResetCode(enteredCode);
    // } on HttpException catch (error) {
    //   print(error);
    //   var errorMessage = 'faild to send code';
    //   showalert(errorMessage);
    //   return;
    // } catch (error) {
    //   print('error:....$error');
    //   showalert('faild to verify the code');
    //   return;
    // }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetNewPassword(token: enteredCode),
      ),
    );
  }
}
