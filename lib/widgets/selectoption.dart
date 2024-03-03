// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../components/buttonpass.dart';
// import '../providers/miscellaneous.dart';
// import 'date_Picker.dart';

// class SelectOptions extends StatelessWidget {
//   final String selecteDate;
//   const SelectOptions({
//     Key? key,
//     required this.selecteDate,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             BtnPassengers(
//               title: "Departure",
//               label: Provider.of<Miscellaneous>(context, listen: false)
//                       .selectedDate ??
//                   selecteDate,
//               color: const Color.fromARGB(255, 14, 141, 52),
//               iconData: Icons.today,
//               onTap: () async {
//                 final result =
//                     await Provider.of<Miscellaneous>(context, listen: false)
//                         .bottomModal(context, const DatePicker(), 0.55);
//               },
//             ),
//             BtnPassengers(
//               title: "Passengers",
//               label: "8 Adults",
//               color: const Color.fromARGB(255, 36, 65, 82),
//               iconData: Icons.wc,
//               onTap: () {},
//             ),
//             // BtnPassengers(
//             //   title: "Return",
//             //   label: "28 Jun, 2022",
//             //   color: const Color.fromARGB(255, 184, 49, 8),
//             //   iconData: Icons.today,
//             //   onTap: () {},
//             // )
//           ],
//         ),
//         const SizedBox(height: 10),
//         // Row(mainAxisAlignment: MainAxisAlignment.center,
//         //   children: [
//         //     BtnPassengers(
//         //       title: "Passengers",
//         //       label: "8 Adults",
//         //       color: const Color.fromARGB(255, 36, 65, 82),
//         //       iconData: Icons.wc,
//         //       onTap: () {},
//         //     ),
//         //     // BtnPassengers(
//         //     //   title: "Class",
//         //     //   label: "Economy",
//         //     //   color: const Color.fromARGB(255, 134, 136, 24),
//         //     //   iconData: Icons.today,
//         //     //   onTap: () {},
//         //     // )
//         //   ],
//         // )
//       ],
//     );
//   }
// }
