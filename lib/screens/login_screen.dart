import 'package:flutter/material.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mengedegna_app/providers/miscellaneous.dart';
import 'package:mengedegna_app/screens/Reset_password.dart';
import 'package:mengedegna_app/screens/home.dart';
import 'package:mengedegna_app/screens/signup_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mengedegna_app/screens/verficationScreen.dart';
import 'package:mengedegna_app/widgets/CButton.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../style/colors.dart';
import '../widgets/user_input.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _obscureText = true;
  bool _isPasswordVisible = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget form() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
              filled: true,
              fillColor: Colors.transparent,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              border: InputBorder.none,
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
            ),
            controller: emailController,
            validator: (val) {
              if (!Fzregex.hasMatch(val!, FzPattern.email)) {
                return 'Please enter valid Email';
              }
              return null;
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: TextFormField(
            maxLines: 1,
            style: TextStyle(color: Colors.white),
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
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
              filled: true,
              fillColor: Colors.transparent,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
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
              RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{4,8}$');
              // RegExp regExp = new RegExp(pattern);
              if (!passwordRegex.hasMatch(val)) {
                return 'password must meet the requirements';
              }
              return null;
            },
            // onSaved: null,
          ),
        ),
      ],
    );
  }

  void onRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                height: 50,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(0, 62, 70, 133),
                  radius: 60,
                  child: Container(
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image(
                          image: AssetImage('assets/logo.png'),
                        ),
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Mengedegna",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Login",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // height: 510,
                width: double.infinity,
                decoration: const BoxDecoration(
                  // color: Color.fromARGB(34, 78, 77, 77),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),
                        form(),
                        SizedBox(
                          height: 25,
                        ),
                        CButton("Login", onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            Provider.of<Auth>(context, listen: false).login(
                                context,
                                emailController.text,
                                passwordController.text);
                          }
                        }),
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ResetPassword(),
                            ));
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'Do not have an account?',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 13,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      SignupScreen.routeName);
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
