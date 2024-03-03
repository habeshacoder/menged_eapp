import 'package:flutter/material.dart';
import 'package:mengedegna_app/style/colors.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../style/style.dart';

class Ticket extends StatefulWidget {
  const Ticket({Key? key}) : super(key: key);

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TicketWidget(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.6,
              isCornerRounded: true,
              padding: const EdgeInsets.all(20),
              child: const TicketData(),
            ),
            const SizedBox(
              height: 20,
            ),
            FractionallySizedBox(
              widthFactor: 0.75,
              child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(
                    //         builder: (ctx) => Reservations(
                    //               searchedDate: _pickedDate!,
                    //               origin: origin!,
                    //               destination: destination!,
                    //               adultPassenger:
                    //                   _pickedPassenger!,
                    //             )));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      primary: AppColors.tertiary,
                      // : AppColors.grey,
                      padding: const EdgeInsets.only(top: 15, bottom: 15)),
                  child: const PrimaryText(
                    text: 'Purchase',
                    size: 20,
                    color: AppColors.white,
                  )),
            ),
            TextButton(
                onPressed: () {},
                child: const Info3Font(
                  text: 'Terms And Conditions',
                  color: AppColors.white,
                ))
          ],
        ),
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(
            //   width: 120.0,
            //   height: 25.0,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30.0),
            //     border: Border.all(width: 1.0, color: Colors.green),
            //   ),
            //   child: const Center(
            //     child: Text(
            //       'Business Class',
            //       style: TextStyle(color: Colors.green),
            //     ),
            //   ),
            // ),
            Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'ADD',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.directions_bus,
                    color: Colors.pink,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'BHD',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Bus Ticket',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ticketDetailsWidget('Passengers', 'Name', 'Date', '28-08-2022'),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 52.0),
                child:
                    ticketDetailsWidget('Plate No.', 'B35996', 'Seat', '66B'),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 12.0, right: 53.0),
              //   child: ticketDetailsWidget('Class', 'Business', 'Seat', '21B'),
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: SizedBox(
              width: 120.0,
              // height: 60.0,
              child: Image(
                image: AssetImage('assets/qr_code.png'),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            '+251911556677',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
            alignment: Alignment.center,
            child: DescriptionFont(
              text: 'Bus company name',
              color: AppColors.tertiary,
            ))
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}
