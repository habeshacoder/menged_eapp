import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.indigo),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 10),
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
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "Booking Success!",
                  style: TextStyle(fontSize: 20),
                )),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "Payment Detail",
                  style: TextStyle(fontSize: 14),
                )),
                ListTile(
                    trailing: Text(
                      "2000 Birr",
                      style: TextStyle(fontSize: 12),
                    ),
                    title: Text(
                      "Amount",
                      style: TextStyle(fontSize: 13),
                    )),
                ListTile(
                    trailing: Text(
                      "Jun 25, 2023",
                      style: TextStyle(fontSize: 12),
                    ),
                    title: Text(
                      "Payment Time",
                      style: TextStyle(fontSize: 13),
                    )),
                ListTile(
                    trailing: Text(
                      "Pending",
                      style: TextStyle(fontSize: 12),
                    ),
                    title: Text(
                      "Payment Status",
                      style: TextStyle(fontSize: 13),
                    )),
                ListTile(
                    trailing: Text(
                      "R0238234789",
                      style: TextStyle(fontSize: 12),
                    ),
                    title: Text(
                      "Ref Number ",
                      style: TextStyle(fontSize: 13),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
