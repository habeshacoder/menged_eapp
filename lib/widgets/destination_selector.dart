// import 'package:flutter/material.dart';
// import 'package:mengedegna_app/style/colors.dart';
// import 'package:mengedegna_app/style/style.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';

// class DestinationSelector extends StatefulWidget {
//   String? origin, destination;
//   DestinationSelector({
//     Key? key,
//     required this.origin,
//     required this.destination,
//   }) : super(key: key);

//   @override
//   State<DestinationSelector> createState() => _DestinationSelectorState();
// }

// class _DestinationSelectorState extends State<DestinationSelector> {
//   List<String> cities = [
//     'Addis Ababa',
//     'Arba Minch',
//     'Bahir Dar',
//     'Debre Zeit',
//     'Hawassa',
//     'Jimma'
//   ];
//   String? _selectedCity;
//   final TextEditingController searchController = TextEditingController();

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//       elevation: 12,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: _originAndDestionation(),
//       ),
//     );
//   }

//   Widget _originAndDestionationIcon() {
//     return Column(
//       // crossAxisAlignment: CrossAxisAlignment.start,
//       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text("ADD",
//             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 15),
//         const Icon(Icons.swap_vert,
//             color: Color.fromARGB(255, 139, 143, 143), size: 40),
//         Text(
//           _selectedCity == 'Arba Minch' ? '250KM' : '',
//           style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//         ),
//         const SizedBox(height: 15),
//         Text(_selectedCity == 'Arba Minch' ? 'AMC' : 'Dest',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//       ],
//     );
//   }

//   Widget dropdown(bool origin) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.8,
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.blueAccent),
//           borderRadius: const BorderRadius.all(Radius.circular(10))),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton2(
//           isExpanded: true,
//           hint: TitleFont(
//             text: origin ? ' From' : ' To',
//             size: 16,
//             color: AppColors.grey,
//           ),
//           items: cities
//               .map((item) => DropdownMenuItem<String>(
//                     value: item,
//                     child: TitleFont(
//                       text: item,
//                       size: 16,
//                     ),
//                   ))
//               .toList(),
//           value: origin ? widget.origin : widget.destination,
//           onChanged: (value) {
//             setState(() {
//               _selectedCity = value as String;
//               origin
//                   ? widget.origin = value.toString()
//                   : widget.destination = value.toString();
//             });
//           },
//           buttonHeight: 40,
//           buttonWidth: 200,
//           itemHeight: 40,
//           dropdownMaxHeight: 300,
//           searchController: searchController,
//           searchInnerWidget: Padding(
//             padding: const EdgeInsets.only(
//               top: 8,
//               bottom: 4,
//               right: 8,
//               left: 8,
//             ),
//             child: TextFormField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 isDense: true,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 8,
//                 ),
//                 hintText: 'Search city...',
//                 hintStyle: const TextStyle(fontSize: 15),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//           // searchMatchFn: (item, searchValue) {
//           //   return (item.value.toString().contains(searchValue));
//           // },
//           onMenuStateChange: (isOpen) {
//             if (!isOpen) {
//               searchController.clear();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _originAndDestionation() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         dropdown(true),
//         const SizedBox(height: 20),
//         dropdown(false),
//       ],
//     );
//   }

//   Widget _iconDestination() {
//     return Column(
//       children: const [
//         Icon(Icons.location_on,
//             color: Color.fromARGB(255, 231, 49, 17), size: 35),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 224, 91, 68), size: 15),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 218, 118, 101), size: 15),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 224, 150, 137), size: 15),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 107, 180, 98), size: 15),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 69, 158, 74), size: 15),
//         Icon(Icons.fiber_manual_record,
//             color: Color.fromARGB(255, 43, 165, 43), size: 12),
//         Icon(Icons.directions_bus,
//             color: Color.fromARGB(255, 29, 192, 7), size: 35),
//       ],
//     );
//   }
// }
