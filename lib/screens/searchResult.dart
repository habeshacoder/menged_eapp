import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mengedegna_app/models/get_all_trips.dart';
import 'package:mengedegna_app/widgets/CButton.dart';

import '../widgets/TripView.dart';

class SearchScreen extends StatelessWidget {
  List<GetAllTrip> trips;
  SearchScreen(this.trips);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.indigoAccent),
      ),
      backgroundColor: Colors.white,
      body: trips.isEmpty
          ? Center(
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 214, 214, 214),
                    radius: 50,
                    child: Icon(
                      FontAwesomeIcons.faceSadCry,
                      color: Color.fromARGB(213, 83, 109, 254),
                      size: 60,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Oops, No trip found!",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CButton("Back to Home", onTap: () {
                      Navigator.pop(context);
                    }),
                  )
                ],
              )),
            )
          : ListView(
              children: trips.map((trip) => TripView(trip)).toList(),
            ),
    );
  }
}
