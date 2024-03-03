// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// import '../providers/miscellaneous.dart';
// import '../style/colors.dart';
// import '../style/style.dart';

// /// My app class to display the date range picker
// class DatePicker extends StatefulWidget {
//   const DatePicker({Key? key}) : super(key: key);

//   @override
//   DatePickerState createState() => DatePickerState();
// }

// /// State for MyApp
// class DatePickerState extends State<DatePicker> {
//   String _selectedDate = '';
//   String _dateCount = '';
//   String _range = '';
//   String _rangeCount = '';
//   bool dateSelected = false;

//   /// The method for [DateRangePickerSelectionChanged] callback, which will be
//   /// called whenever a selection changed on the date picker widget.
//   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     /// The argument value will return the changed date as [DateTime] when the
//     /// widget [SfDateRangeSelectionMode] set as single.
//     ///
//     /// The argument value will return the changed dates as [List<DateTime>]
//     /// when the widget [SfDateRangeSelectionMode] set as multiple.
//     ///
//     /// The argument value will return the changed range as [PickerDateRange]
//     /// when the widget [SfDateRangeSelectionMode] set as range.
//     ///
//     /// The argument value will return the changed ranges as
//     /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
//     /// multi range.
//     setState(() {
//       dateSelected = true;
//       if (args.value is PickerDateRange) {
//         _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
//             // ignore: lines_longer_than_80_chars
//             ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
//       } else if (args.value is DateTime) {
//         _selectedDate = DateFormat('dd/MM/yyyy').format(args.value);
//       } else if (args.value is List<DateTime>) {
//         _dateCount = args.value.length.toString();
//       } else {
//         _rangeCount = args.value.length.toString();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           Text('Selected date: $_selectedDate'),
//           // Text('Selected date count: $_dateCount'),
//           // Text('Selected range: $_range'),
//           // Text('Selected ranges count: $_rangeCount'),
//           SfDateRangePicker(
//             selectionColor: AppColors.secondary,
//             onSelectionChanged: _onSelectionChanged,
//             selectionMode: DateRangePickerSelectionMode.single,
//             minDate: DateTime.now().add(const Duration(days: 1)),
//             maxDate: DateTime.now().add(const Duration(days: 30)),
//             // initialSelectedRange: PickerDateRange(
//             //     DateTime.now().subtract(const Duration(days: 4)),
//             //     DateTime.now().add(const Duration(days: 3))),
//           ),
//           FractionallySizedBox(
//             widthFactor: 1,
//             child: ElevatedButton(
//                 onPressed: dateSelected
//                     ? () {
//                         Navigator.of(context).pop();

//                         Provider.of<Miscellaneous>(context, listen: false)
//                             .selectedDate = _selectedDate;
//                       }
//                     : () {
//                         Navigator.of(context).pop();
//                       },
//                 style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25)),
//                     primary:
//                         dateSelected ? AppColors.secondary : AppColors.grey,
//                     padding: const EdgeInsets.only(top: 15, bottom: 15)),
//                 child: PrimaryText(
//                   text: dateSelected ? 'Pick Date' : 'Cancel',
//                   size: 20,
//                   color: AppColors.white,
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }
