import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mengedegna_app/screens/receiptScreen.dart';
import 'package:mengedegna_app/widgets/CButton.dart';
import 'package:mengedegna_app/widgets/payMethods.dart';
import 'package:provider/provider.dart';

import '../providers/request.dart';
import '../widgets/banksCard.dart';

class PayScreen extends StatefulWidget {
  Map data;
  PayScreen(this.data);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  String method = "Comercial Bank of Ethiopia";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Payment",
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 14,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 252, 252, 252),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.indigo),
        ),
        body: ListView(children: [
          Container(
              child: CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: [
              PayMethods(
                  title: "CBE",
                  body: "1000345459783",
                  colors: [
                    Color.fromARGB(255, 190, 132, 6),
                    Color.fromARGB(255, 255, 156, 7)
                  ],
                  onMoreTap: () {},
                  subIcon: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image(
                      image: AssetImage("assets/icons/cbe.png"),
                    ),
                  )),
              PayMethods(
                  title: "Dashen",
                  body: "9008345459783",
                  onMoreTap: () {},
                  subIcon: CircleAvatar(
                    child: Image(
                      image: AssetImage("assets/icons/dashen.jpg"),
                    ),
                  )),
              PayMethods(
                  title: "Abyssinia",
                  body: "4597830566",
                  colors: [Color.fromARGB(255, 190, 150, 6), Colors.amber],
                  onMoreTap: () {},
                  subIcon: CircleAvatar(
                    child: Image(
                      image: AssetImage("assets/icons/abyssinia.png"),
                    ),
                    // backgroundImage: ,
                  )),
            ],
          )),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(10, 0, 0, 0),
                        spreadRadius: 3,
                        blurRadius: 15)
                  ]),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Amount",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                    leading: Icon(
                      FontAwesomeIcons.moneyBill1,
                      size: 20,
                      color: Colors.indigo,
                    ),
                    trailing: Text(
                      "3000 Birr",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(10, 0, 0, 0),
                        spreadRadius: 3,
                        blurRadius: 15)
                  ]),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton(
                      underline: SizedBox(),
                      value: method,
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            "Comercial Bank of Ethiopia",
                            style: TextStyle(fontSize: 12),
                          ),
                          value: "Comercial Bank of Ethiopia",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Abysinia Bank",
                            style: TextStyle(fontSize: 12),
                          ),
                          value: "Abysinia Bank",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Dashen Bank",
                            style: TextStyle(fontSize: 12),
                          ),
                          value: "Bitcoin",
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          method = value as String;
                        });
                      },
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: Text(
                        "Transaction No",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CButton(
                    "Continue",
                    color: Color.fromARGB(216, 63, 81, 181),
                    onTap: () async {
                      await context
                          .read<Request>()
                          .BookTrip(context, widget.data)
                          .then((value) => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ReceiptScreen()))
                              });
                    },
                  )
                ],
              )),
        ]));
  }
}
