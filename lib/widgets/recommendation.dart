// import 'package:flightbooking/screens/reservation.dart';
import 'package:flutter/material.dart';

import '../components/recommendation.dart';

class Recommendation extends StatelessWidget {
  const Recommendation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Recommended",
            style: TextStyle(
                color: Color.fromARGB(255, 58, 53, 36),
                fontSize: 17,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              RecommendationItem(
                title: "Jimma",
                price: "380 Birr",
                color: const Color.fromARGB(255, 126, 125, 65),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  // MaterialPageRoute(
                  // builder: (context) => const Reservations(
                  //     color: Color.fromARGB(255, 240, 136, 176))));
                },
              ),
              const SizedBox(
                width: 10,
              ),
              RecommendationItem(
                  title: "Bahir Dar",
                  price: "500 Birr",
                  color: const Color.fromARGB(255, 69, 79, 211),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Reservations(
                    //             color: Color.fromARGB(255, 8, 151, 187))));
                  }),
              const SizedBox(
                width: 10,
              ),
              RecommendationItem(
                  title: "Arba Minch",
                  price: "220 Birr",
                  color: const Color.fromARGB(248, 126, 179, 223),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Reservations(
                    //             color: Color.fromARGB(249, 204, 143, 85))));
                  }),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}
