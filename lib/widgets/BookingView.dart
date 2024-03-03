import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mengedegna_app/providers/miscellaneous.dart';
import 'package:mengedegna_app/providers/request.dart';
import 'package:provider/provider.dart';
import '../models/booking.dart';

class BookingView extends StatefulWidget {
  const BookingView({
    Key? key,
    required this.booking,
  }) : super(key: key);

  final BookingModel booking;

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  cancelBooking() async {
    await context
        .read<Request>()
        .deleteBooking(context, widget.booking.bookingPublicId);
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime bookDate = DateTime.parse(widget.booking.date as String);
    bool isExpired = bookDate.difference(currentDate).isNegative;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                  backgroundImage: NetworkImage(widget
                      .booking.trip!.travelAgency!.profileImageUrl as String)),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  widget.booking.trip!.travelAgency!.name as String,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_horiz),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
                color: Color.fromARGB(14, 0, 0, 0),
                borderRadius: BorderRadius.circular(12)),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.booking.trip!.departureTime as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(""),
                  Text(
                    widget.booking.trip!.arrivalTime as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.booking.trip!.route!.departureAddress!.city
                        as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  Text(
                    widget.booking.trip!.route!.destinationAddress!.city
                        as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.chair_sharp,
                      size: 17,
                      // size: 1,
                    ),
                    label: Text(
                      "1 ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('MMM d, yyyy')
                        .format(DateTime.parse(widget.booking.date as String)),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isExpired
                  ? TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(31, 83, 109, 254))),
                      onPressed: () {},
                      icon: Icon(Icons.dangerous,
                          size: 16, color: Color.fromARGB(255, 20, 20, 20)),
                      label: Text(
                        "Expired",
                        style: TextStyle(color: Colors.redAccent, fontSize: 12),
                      ))
                  : TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(31, 83, 109, 254))),
                      onPressed: () {},
                      icon: Icon(Icons.check_circle,
                          size: 16, color: Color.fromARGB(255, 0, 156, 81)),
                      label: Text(
                        "Active",
                        style:
                            TextStyle(color: Colors.indigoAccent, fontSize: 12),
                      )),
              InkWell(
                onTap: () {
                  context.read<Miscellaneous>().warningAlert(
                      "Are you sure you want to cancel the booking?",
                      context,
                      cancelBooking);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Container(
          //     child: InkWell(child: Icon(Icons.more_vert)),
          //   ),
          // )
        ],
      ),
    );
  }
}
