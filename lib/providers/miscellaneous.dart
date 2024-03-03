import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Miscellaneous with ChangeNotifier {
  String? selectedDate;
  String? departure;
  String? destination;

  changeDeparture(String? number) {
    departure = number;
    notifyListeners();
  }

  changeDestination(String? number) {
    destination = number;
    notifyListeners();
  }

  String convertUTF8(String value) {
    var utf8Runes = value.runes.toList();
    return const Utf8Decoder().convert(utf8Runes);
  }

  void bottomModal(BuildContext context, Widget widget) async {
    // final deviceSize = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        isScrollControlled: true,
        elevation: 5,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          );
        });
  }

  void centerDialogue(BuildContext context, Widget widget, double size) async {
    final deviceSize = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: SizedBox(
                  height: deviceSize.height * size,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget,
                  )));
        });
  }

  scaffoldMessage(context, String message, Color bkgrdClr) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      duration: const Duration(milliseconds: 1300),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: bkgrdClr,
    ));
  }

  warningAlert(String message, BuildContext context, Function fun) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: message,
      style: AlertStyle(
        backgroundColor: Colors.white,
        titleStyle: TextStyle(fontFamily: "Mont", fontSize: 13),
      ),
      buttons: [
        DialogButton(
          color: Colors.greenAccent,
          child: Text(
            "Yes",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontFamily: "Mont"),
          ),
          onPressed: () async {
            Navigator.pop(context);
            await fun();
          },
          width: 120,
        ),
        DialogButton(
          color: Colors.redAccent,
          child: Text(
            "No",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontFamily: "Mont"),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }
}
