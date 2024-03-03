import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mengedegna_app/screens/payScreen.dart';
import 'package:mengedegna_app/screens/receiptScreen.dart';
import 'package:provider/provider.dart';
import '../models/get_all_trips.dart';
import '../providers/auth.dart';
import '../providers/request.dart';

class BookingDetail extends StatelessWidget {
  final GetAllTrip trip;
  BookingDetail(this.trip);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Bus Booking Details',
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 15,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.indigo),
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(20, 0, 0, 0),
                        spreadRadius: 3,
                        blurRadius: 15)
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                                image: NetworkImage(
                                    trip.travelAgency.profileImageUrl)),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              trip.travelAgency.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.justify,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text("About", style: TextStyle(color: Colors.indigo)),
                    Container(
                      child: Text(
                        trip.travelAgency.description,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    "About Trip",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(20, 0, 0, 0),
                        spreadRadius: 3,
                        blurRadius: 15)
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                        leading: Icon(
                          Icons.location_history_rounded,
                          color: Colors.indigo,
                        ),
                        subtitle: Text(
                          "Departure Address",
                          style: TextStyle(fontSize: 12),
                        ),
                        title: Text(
                          trip.route.departureAddress.city,
                          style: TextStyle(fontSize: 13),
                        )),
                    ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Colors.indigo,
                        ),
                        subtitle: Text(
                          "Destination Address",
                          style: TextStyle(fontSize: 12),
                        ),
                        title: Text(
                          trip.route.destinationAddress.city,
                          style: TextStyle(fontSize: 13),
                        )),
                    ListTile(
                        leading: Icon(
                          Icons.monetization_on,
                          color: Colors.indigo,
                        ),
                        subtitle: Text(
                          "Price",
                          style: TextStyle(fontSize: 12),
                        ),
                        title: Text(
                          trip.price.toString(),
                          style: TextStyle(fontSize: 13),
                        )),
                    ListTile(
                        leading: Icon(
                          Icons.timer_sharp,
                          color: Colors.indigo,
                        ),
                        subtitle: Text(
                          "Departure Time",
                          style: TextStyle(fontSize: 12),
                        ),
                        title: Text(
                          trip.departureTime,
                          style: TextStyle(fontSize: 13),
                        )),
                    ListTile(
                        leading: Icon(
                          Icons.timer_sharp,
                          color: Colors.indigo,
                        ),
                        subtitle: Text(
                          "Arrival Time",
                          style: TextStyle(fontSize: 12),
                        ),
                        title: Text(
                          trip.arrivalTime,
                          style: TextStyle(fontSize: 13),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    "Contact",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(20, 0, 0, 0),
                        spreadRadius: 3,
                        blurRadius: 15)
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.indigo,
                        ),
                        subtitle: Text(
                          "Phone Number",
                          style: TextStyle(fontSize: 12),
                        ),
                        title: Text(
                          trip.travelAgency.owner.phoneNumber,
                          style: TextStyle(fontSize: 13),
                        )),
                    ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.indigo,
                        ),
                        subtitle: Text(
                          "Email",
                          style: TextStyle(fontSize: 12),
                        ),
                        title: Text(
                          trip.travelAgency.owner.userName,
                          style: TextStyle(fontSize: 13),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {
          var userData = context.read<Request>().userInfo;

          Map data = {
            "user": userData!.toJson(),
            "travelAgencyPID": trip.travelAgency.agencyPublicId,
            "travelerInfo": {
              "passengerName": userData.firstName.toString() +
                  " " +
                  userData.lastName.toString(),
              "passengerAddress": userData.address!.city,
              "passengerPhone": userData.phoneNumber
            },
            "tripPID": trip.tripPublicId,
            "isSelf": true,
            "isAgent": false,
          };
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => PayScreen(data)));
          // await context.read<Request>().BookTrip(context, data).then((value) =>
          //     {

          //     });
        },
        child: Container(
            width: 150,
            decoration: BoxDecoration(
                color: Colors.indigo, borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.book, color: Colors.white),
                Text(
                  "Book Now",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            )),
      ),
    );
  }
}
