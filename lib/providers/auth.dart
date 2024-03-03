import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mengedegna_app/models/user_info_model.dart';
import 'package:mengedegna_app/providers/miscellaneous.dart';
import 'package:mengedegna_app/providers/request.dart';
import 'package:mengedegna_app/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login_screen.dart';

class Auth with ChangeNotifier {
  int timeout = 10;
  String? token, pid;
  String backendUrl = 'https://walrus-app-ahi9u.ondigitalocean.app';
  String apiToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9";
  bool get isAuth {
    if (token != null && pid != null) {
      return true;
    } else {
      return false;
    }
  }

  Future checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('userToken');
    pid = pref.getString('userPID');
  }

  Future sendVerification(
      Map<String, String> newData, BuildContext context) async {
    final url = Uri.parse('$backendUrl/public/send-email-conformation');
    try {
      final jsonBody = json.encode(
        {
          "firstName": newData['firstName'].toString(),
          "lastName": newData['lastName'].toString(),
          "userName": newData['email']!.replaceAll(' ', ''),
          "userPassword": newData['password'],
          "phoneNumber": newData['phone'],
          "address": {
            "street": newData['street'],
            "city": newData['city'],
          },
        },
      );
      final response = await http.post(
        url,
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        Provider.of<Miscellaneous>(context, listen: false)
            .scaffoldMessage(context, 'Confirmation email sent!', Colors.green);
      }
      if (response.statusCode == 409) {
        Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
            context,
            'Your Email address already exists! Please use another email!',
            Colors.red);
      }
    } on TimeoutException {
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context, 'Network is timedout please try again later!', Colors.red);
    } on SocketException {
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context,
          'Network is unreachable! Please check your internet connection!',
          Colors.red);
    }
  }

  Future<List> checkToken(Map<String, String> newData) async {
    final url = Uri.parse('$backendUrl/public/check-token');
    List values;
    try {
      final jsonBody = json.encode(
        {
          "token": newData['token'],
          "username": newData['email'],
          "phone": "",
          "message": "",
          "roles": []
        },
      );
      print(jsonBody);
      final response = await http.post(
        url,
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(Duration(seconds: timeout));
      var responseData = jsonDecode(response.body);
      String message = responseData['message'];
      values = [response.statusCode, message];
    } catch (e) {
      print(e.toString());
      throw e;
    }
    return values;
  }

  Future<void> signup(
    Map<String, String> newData,
    context,
  ) async {
    // Provider.of<Miscellaneous>(context, listen: false).loadingDialogue(context);
    // int timeout = 10;
    final url = Uri.parse('$backendUrl/public/createUser');

    try {
      final jsonBody = json.encode(
        {
          "firstName": newData['firstName'].toString(),
          "lastName": newData['lastName'].toString(),
          "userName": newData['email']!.replaceAll(' ', ''),
          "userPassword": newData['password'],
          "phoneNumber": newData['phone'],
          "address": {
            "street": newData['street'],
            "city": newData['city'],
          },
        },
      );
      final response = await http.post(
        url,
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(Duration(seconds: timeout));
      print(response.statusCode);

      final responseData = json.decode(response.body);
      print('$responseData');
      if (responseData['Phone'] == 'Email is used') {
        Navigator.of(context).pop();
        Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
            context, 'This email is already in use', Colors.red);
      }
      if (responseData['Phone is required'] ==
          'Phone number should be at least 10 digit') {
        Navigator.of(context).pop();
        Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
            context, 'This email is already in use', Colors.red);
      }
      // if (responseData['Phone'] == 'Phone number is used') {
      //   Navigator.of(context).pop();
      //   Provider.of<Fetch>(context, listen: false).scaffoldMessage(
      //       context, 'This phone number is already in use', Colors.red);
      // }

      if (response.statusCode == 201 || response.statusCode == 200) {
        Navigator.of(context).pop();
        // Provider.of<Auth>(context, listen: false)
        //     .loginEnforceDialogue(context, 'Signup Successful!', true);
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
            context,
            'Signup successful! Please login to continue.',
            Colors.green);
      } else if (response.statusCode == 406) {
        Navigator.of(context).pop();
        Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
            context, 'This phone number is already in use.', Colors.red);
      }

      //notify and set prefs
    } on TimeoutException {
      Navigator.of(context).pop();
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context, 'Network is timedout please try again later', Colors.red);
    } on SocketException {
      Navigator.of(context).pop();
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context,
          'Network is unreachable! Please check your internet connection.',
          Colors.red);
    }
  }

  Future<void> login(context, String email, String password) async {
    // loadingDialogue(context);
    final url = Uri.parse('$backendUrl/public/authenticate');

    try {
      final jsonBody = json.encode(
        {
          "password": password,
          "userName": email,
        },
      );
      final response = await http.post(
        url,
        body: jsonBody,
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: timeout));
      final responseData = jsonDecode(response.body); //print response.body
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        token = responseData['token'];
        pid = responseData['pid'];
        final pref = await SharedPreferences.getInstance();
        await pref.setString('savedUserName', email);
        await pref.setString('savedPassword', password);
        await pref.setString('userPID', pid!);
        await pref.setString('userToken', token!);
        // Provider.of<Fetch>(context, listen: false).getCurrentLocation();
        // String? savedLocationLat = pref.getString('savedLocationLat');
        // String? savedLocationLon = pref.getString('savedLocationLon');
        // if (restaurantRegister == true) {
        // Navigator.of(context).pop();
        EasyLoading.dismiss();

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const BottomNav()));
      } else if (response.statusCode == 500) {
        EasyLoading.dismiss();
        Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
            context, 'Username or password is incorrect!', Colors.red);
      } else {
        // Navigator.of(context).pop();
        EasyLoading.dismiss();
        Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
            context,
            'Unexpected error occured! Please try again later.',
            Colors.red);
      }
    } on TimeoutException {
      EasyLoading.dismiss();
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context, 'Network is timedout please try again later', Colors.red);
    } on SocketException {
      EasyLoading.dismiss();
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context,
          'Network is unreachable! Please check your internet connection.',
          Colors.red);
    }
  }

  Future<void> emailVerificationCodeRequest(context, String email) async {
    final url = Uri.parse('backendUrl/public/send-email-conformation');

    try {
      final jsonBody = json.encode(
        {
          "userName": email,
        },
      );
      final response = await http.post(
        url,
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: timeout));

      // final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        Provider.of<Miscellaneous>(context, listen: false)
            .scaffoldMessage(context, 'Confirmation email sent!', Colors.green);
      }
      if (response.statusCode == 409) {
        Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
            context,
            'Your Email address already exists! Please use another email!',
            Colors.red);
      }

      //notify and set prefs
    } on TimeoutException {
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context, 'Network is timedout please try again later!', Colors.red);
    } on SocketException {
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context,
          'Network is unreachable! Please check your internet connection!',
          Colors.red);
    }
  }

  Future<void> logOut(context) async {
    // Provider.of<Fetch>(context, listen: false).lisOfFavRestaurantId.clear();
    // Provider.of<Fetch>(context, listen: false).lisOfFavFoodId.clear();
    token = null;
    pid = null;
    // Provider.of<Fetch>(context, listen: false).token = null;
    // Provider.of<Fetch>(context, listen: false).pid = null;

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    // notifyListeners();
  }

  // send code for password reset
  Future<void> sendCodeForPasswordReset(Map<String, dynamic> emailData) async {
    final baseUrl = backendUrl;
    final url = '$baseUrl/public/email-check';
    String email = emailData["email"];

    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode({
            "email": email.toString(),
          }));
      print('response..................................after http.post:' +
          response.body);

      final extractedResponse = json.decode(response.body);
      if (extractedResponse['message'] != null) {
        throw '${extractedResponse['message']}';
      }
    } catch (error) {
      throw error;
    }
  }

  //verify verification code
  // Future<bool?> verifyPasswordResetCode(String verifyCode) async {
  //   final baseUrl = backendUrl;
  //   final url = '$baseUrl/seller-profiles';
  //   String code = verifyCode;

  //   try {
  //     final response = await http.post(Uri.parse(url),
  //         headers: <String, String>{'Content-Type': 'application/json'},
  //         body: jsonEncode({
  //           "code": code.toString(),
  //         }));
  //     print('response..................................after http.post:' +
  //         response.body);

  //     final extractedResponse = json.decode(response.body);
  //     if (extractedResponse['message'] != null) {
  //       throw '${extractedResponse['message']}';
  //     }
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  //reset password
  Future<bool?> resetPassword(String userData, dynamic token) async {
    final baseUrl = backendUrl;
    final url = '$baseUrl/public/reset-password';
    String password = userData;
    //fetch email from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode({
            "email": email.toString(),
            "token": token.toString(),
            "password": userData.toString()
          }));
      print('response..................................after http.post:' +
          response.body);

      final extractedResponse = json.decode(response.body);
      if (extractedResponse['message'] != null) {
        throw '${extractedResponse['message']}';
      }
    } catch (error) {
      throw error;
    }
  }
}
