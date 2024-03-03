import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mengedegna_app/main.dart';
import 'package:mengedegna_app/screens/verficationScreen.dart';
import 'package:mengedegna_app/style/colors.dart';
import 'package:mengedegna_app/style/style.dart';
import 'package:mengedegna_app/widgets/CButton.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/user_input.dart';
import 'login_screen.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup-screen';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _obscureText = true;
  bool _obscureTextForConfirm = true;

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

  Widget signUpWith(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(onPressed: () {}, child: const Text('Sign in')),
        ],
      ),
    );
  }

  Widget form() {
    return Column(
      children: [
        //firstName
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: TextFormField(
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
              hintText: 'First Name',
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
            ),
            controller: firstNameController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter valid First Name';
              }
              return null;
            },
          ),
        ),
        //lastName
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: TextFormField(
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
              hintText: 'Last Name',
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
            ),
            controller: lastNameController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter valid Last Name ';
              }
              return null;
            },
          ),
        ),
        //email
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
        //phone
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: TextFormField(
            keyboardType: TextInputType.phone,
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
              hintText: 'Phone Number',
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
            ),
            controller: phoneController,
            validator: (val) {
              if (!Fzregex.hasMatch(val!, FzPattern.phone) ||
                  val.characters.length < 10) {
                return 'Please enter valid Phone Number';
              }
              return null;
            },
          ),
        ),
        //Street
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: TextFormField(
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
              hintText: 'Street',
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
            ),
            controller: streetController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter valid Street';
              }
              return null;
            },
            onSaved: null,
          ),
        ),
        //city
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: TextFormField(
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
              hintText: 'City',
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
            ),
            controller: cityController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter valid City';
              }
              return null;
            },
            onSaved: null,
          ),
        ),
        //password
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
        //confirm password
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
                  icon: _obscureTextForConfirm
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
              hintText: 'Confirm Password',
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
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
      ],
    );
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
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 20, top: 30),
                child: Text("Sign Up",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                // height: 510,
                width: double.infinity,
                decoration: const BoxDecoration(
                  // color: Color.fromARGB(138, 78, 77, 77),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20),
                          form(),
                          SizedBox(height: 20),
                          CButton(
                            "Sign Up",
                            onTap: () {
                              // print(emailController);
                              // print(passwordController);
                              Map<String, String> userData = {
                                'firstName': firstNameController.text,
                                'lastName': lastNameController.text,
                                'email': emailController.text,
                                'phone': phoneController.text,
                                'street': streetController.text,
                                'city': cityController.text,
                                'password': passwordController.text
                              };
                              print('user data://///');
                              print(userData);
                              if (_formKey.currentState!.validate()) {
                                Provider.of<Auth>(context, listen: false)
                                    .sendVerification(userData, context)
                                    .then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              VerificationScreen(userData)));
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(174, 0, 0, 0),
                                      content: Text(
                                        'Processing...',
                                      )),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          const Divider(thickness: 0, color: Colors.white),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Aleardy have an account?',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 13,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        LoginScreen.routeName);
                                  },
                                  child: Text(
                                    "Login",
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
