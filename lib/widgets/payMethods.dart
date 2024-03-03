import 'package:flutter/material.dart';

class PayMethods extends StatelessWidget {
  final String title;
  final String body;
  final Function() onMoreTap;

  final String subInfoTitle;
  final String subInfoText;
  final Widget subIcon;
  final List<Color> colors;

  const PayMethods(
      {required this.title,
      this.body = """Pay with paypal and get 10% discount.""",
      required this.onMoreTap,
      this.subIcon = const Icon(
        Icons.paypal,
        color: Colors.white,
      ),
      this.subInfoText = "10% ",
      this.subInfoTitle = "Discount",
      this.colors = const [Colors.blueAccent, Colors.blue],
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: Offset(0, 3),
              blurRadius: 3,
              spreadRadius: 3,
            )
          ],
          gradient: RadialGradient(
            colors: colors,
            focal: Alignment.topCenter,
            radius: .85,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 75,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: Color.fromARGB(68, 255, 255, 255),
                ),
                child: GestureDetector(
                  onTap: onMoreTap,
                  child: Center(
                      child: Text(
                    "More",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            body,
            style: TextStyle(
              color: Colors.white.withOpacity(.75),
              fontSize: 14,
              letterSpacing: 6,
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: colors[0], child: subIcon),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subInfoTitle,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        subInfoText,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
