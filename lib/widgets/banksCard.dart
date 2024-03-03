import 'package:flutter/material.dart';

class BanksCard extends StatelessWidget {
  final String title;
  final String disc;
  final Color color;
  BanksCard(
      {Key? key,
      this.title = "title",
      this.disc = "disc",
      this.color = Colors.white})
      : super(key: key);

  final primaryColor = Color.fromARGB(82, 68, 56, 202);
  final secondaryColor = Color.fromARGB(68, 108, 40, 217);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 5,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              backgroundColor: accentColor.withOpacity(.05),
              radius: 25,
              child: Icon(
                Icons.diamond,
                color: color,
              )),
          const SizedBox(
            height: 15,
          ),
          Text(title,
              style: TextStyle(
                  color: accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 3.5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              disc,
              style: TextStyle(
                color: accentColor,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              decoration: BoxDecoration(
                color: Color.fromARGB(80, 255, 255, 255),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Buy",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
