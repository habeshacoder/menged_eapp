import 'package:flutter/material.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:mengedegna_app/screens/signup_screen.dart';

import '../style/colors.dart';
import '../style/style.dart';

class PreSignupScreen extends StatefulWidget {
  const PreSignupScreen({Key? key}) : super(key: key);

  @override
  State<PreSignupScreen> createState() => _PreSignupScreenState();
}

class _PreSignupScreenState extends State<PreSignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Widget userInput(
      TextEditingController? userInput,
      String hintTitle,
      TextInputType keyboardType,
      BuildContext context,
      String? Function(String?)? validator,
      String? Function(String?)? onSaved) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextFormField(
          maxLength: 40,
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: const TextStyle(
                fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
          validator: validator!,
          onSaved: onSaved,
        ),
      ),
    );
  }

  Widget form() {
    return Column(
      children: [
        userInput(emailController, 'Email', TextInputType.name, context, (val) {
          if (!Fzregex.hasMatch(val!, FzPattern.email)) {
            return 'Please enter valid Email';
          }
          return null;
        }, (val) {
          return emailController.text = val!;
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/bus_for_login_2.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 3,
                child: Container(
                  // height: 510,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(138, 78, 77, 77),
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
                          const SizedBox(height: 20),
                          form(),
                          ElevatedButton(
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //         content: Text('Processing Data')),
                                //   );
                                //   print(emailController.text);
                                // }
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const SignupScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  primary: AppColors.tertiary,
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15)),
                              child: const PrimaryText(
                                text: 'Send Reguest',
                                size: 20,
                                color: AppColors.white,
                              )),
                          const SizedBox(height: 10),
                          const Divider(thickness: 0, color: Colors.white),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
