import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  const UserInput({
    Key? key,
    required this.userInput,
    required this.hintTitle,
    required this.keyboardType,
    required this.context,
    this.obscureText,
    required this.validator,
    required this.onSaved,
  }) : super(key: key);

  final TextEditingController? userInput;
  final String hintTitle;
  final TextInputType keyboardType;
  final BuildContext context;
  final bool? obscureText;
  final String? Function(String? p1)? validator;
  final String? Function(String? p1)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: TextFormField(
        obscureText: obscureText ?? false,
        controller: userInput,
        autocorrect: false,
        // autofocus: false,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          labelText: hintTitle,
          errorStyle: TextStyle(color: Colors.red[200]),
          labelStyle: const TextStyle(fontSize: 13, color: Colors.white),
        ),
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
