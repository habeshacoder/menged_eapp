import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mengedegna_app/models/booking.dart';
import 'package:mengedegna_app/providers/request.dart';
import 'package:provider/provider.dart';

import '../widgets/BookingView.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  Future<List<BookingModel>>? getBookings;
  @override
  void initState() {
    getBookings =
        Provider.of<Request>(context, listen: false).getBooking(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: getBookings,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.indigo),
            );
          }
          List<BookingModel> bookings = snapshot.data as List<BookingModel>;
          return ListView.builder(
            itemCount: bookings.length + 1,
            itemBuilder: ((context, index) {
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    "Bookings",
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 16,
                    ),
                  ),
                );
              }
              BookingModel booking = bookings[index - 1];
              return BookingView(booking: booking);
            }),
          );
        });
  }
}
