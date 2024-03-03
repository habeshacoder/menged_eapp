import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../widgets/CButton.dart';
import 'login_screen.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/ver-screen';
  Map<String, String> userData;
  VerificationScreen(this.userData);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final emailController = TextEditingController();

  void onRefresh() {
    setState(() {});
  }

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    var focusedBorderColor = Color.fromARGB(255, 227, 224, 255);
    var fillColor = Color.fromRGBO(243, 246, 249, 0);
    var borderColor = Color.fromARGB(102, 189, 189, 189);
    final defaultPinTheme = PinTheme(
      width: 35,
      height: 35,
      textStyle: const TextStyle(
        fontSize: 13,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/bus_for_sign_up.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
            color: Color.fromARGB(179, 0, 0, 0),
            colorBlendMode: BlendMode.darken,
          ),
          ListView(
            children: [
              SizedBox(
                height: 180,
              ),
              Container(
                child: Text("Verify Email ",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              SizedBox(height: 15),
              Container(
                // height: 510,
                width: double.infinity,
                decoration: const BoxDecoration(
                  // color: Color.fromARGB(34, 78, 77, 77),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Pinput(
                    length: 6,
                    controller: pinController,
                    focusNode: focusNode,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: defaultPinTheme,
                    errorText: errorMessage,
                    forceErrorState: errorMessage == null ? false : true,
                    onClipboardFound: (value) {
                      pinController.setText(value);
                    },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) async {
                      var newData = {...widget.userData, "token": pin};
                      var data = await Provider.of<Auth>(context, listen: false)
                          .checkToken(newData);
                      if (data[0] == 200) {
                        await Provider.of<Auth>(context, listen: false)
                            .signup(widget.userData, context);
                      } else {
                        setState(() {
                          errorMessage = data[1];
                        });
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        errorMessage = null;
                      });
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: focusedBorderColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      textStyle: TextStyle(color: Colors.white),
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    errorTextStyle:
                        TextStyle(fontSize: 15, color: Colors.redAccent),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: CButton(
                  "Continue",
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Aleardy have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
