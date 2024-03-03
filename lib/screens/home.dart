import 'dart:async';

import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mengedegna_app/models/get_all_cities_model.dart';
import 'package:mengedegna_app/providers/miscellaneous.dart';
import 'package:mengedegna_app/providers/request.dart';
import 'package:mengedegna_app/widgets/payMethods.dart';
import 'package:mengedegna_app/screens/searchResult.dart';
import 'package:mengedegna_app/screens/searched_trips.dart';
import 'package:mengedegna_app/style/colors.dart';
import 'package:mengedegna_app/widgets/CButton.dart';
import 'package:mengedegna_app/widgets/date_Picker.dart';
import 'package:mengedegna_app/widgets/destination_selector.dart';
import 'package:mengedegna_app/widgets/dropDownList.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../components/buttonpass.dart';
import '../models/get_all_trips.dart';
import '../style/style.dart';
import '../widgets/TripView.dart';
import '../widgets/recommendation.dart';
import '../widgets/selectoption.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _selectedDate,
      _selectedCity,
      _pickedDate,
      _pickedPassenger,
      origin,
      destination;
  bool dateSelected = false,
      activeButton = false,
      activeButtonA = false,
      isRoundTrip = false,
      isSearching = false;
  Future<List<AllCitiesStation>>? allCities;
  Future<List<GetAllTrip>>? getAllTrip;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController adultController = TextEditingController();
  final TextEditingController childController = TextEditingController();
  TextEditingController depCityController = TextEditingController();
  TextEditingController desCityController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request();
    adultController.text = '1';
    _pickedPassenger = '1';
  }

  void request() {
    allCities =
        Provider.of<Request>(context, listen: false).getAllCityStation(context);
    getAllTrip =
        Provider.of<Request>(context, listen: false).getAllTrips(context);
  }

  FutureOr onGoBack(dynamic value) {
    onRefresh();
  }

  void onRefresh() {
    setState(() {});
  }

  Widget datePicker() {
    activeButton = false;
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Selected date:',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      _selectedDate ?? 'not selected',
                      style: TextStyle(
                        fontSize: 14,
                        color: _selectedDate != null
                            ? Colors.indigoAccent
                            : AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SfDateRangePicker(
                selectionColor: Colors.indigoAccent,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  setState(() {
                    dateSelected = true;
                    activeButton = true;
                    if (args.value is DateTime) {
                      _selectedDate =
                          DateFormat('EEEE dd/MM/yyyy').format(args.value);
                      _pickedDate = DateFormat('yyyy-MM-dd').format(args.value);
                      dateController.text = _selectedDate ?? "";
                    }
                    //
                  });
                },
                selectionMode: DateRangePickerSelectionMode.single,
                minDate: DateTime.now().add(const Duration(days: 1)),
                maxDate: DateTime.now().add(const Duration(days: 30)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _selectedDate = "";
                      });
                    },
                    child: Text("CANCEL"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (activeButton) {
                        setState(() {
                          Navigator.of(context).pop();
                          onRefresh();
                          setState(() {
                            activeButton = false;
                          });
                        });
                      }
                    },
                    child: Text("OK"),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -2,
                child: Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                ),
              ),
              CircleAvatar(
                backgroundColor: Color.fromARGB(0, 62, 70, 133),
                radius: 40,
                child: Container(
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image(
                        image: AssetImage('assets/logo.png'),
                      ),
                    )),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Book tickets for your next trip!",
            style: GoogleFonts.mavenPro(
              fontSize: 22,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        FutureBuilder<Object>(
            future: allCities,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.indigoAccent,
                  ),
                );
              }
              List<AllCitiesStation> allCities =
                  snapshot.data as List<AllCitiesStation>;
              final List<SelectedListItem> _listOfCities = allCities
                  .map((city) => SelectedListItem(
                        name: city.city + " Station-" + city.station,
                        value: city.id.toString(),
                      ))
                  .toList();
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(20, 0, 0, 0),
                          spreadRadius: 3,
                          blurRadius: 15)
                    ]),
                child: Column(
                  children: [
                    DropDownList(
                      textEditingController: depCityController,
                      title: "Departure",
                      isCitySelected: true,
                      cities: _listOfCities,
                      icon: Icon(Icons.location_history),
                    ),
                    DropDownList(
                      textEditingController: desCityController,
                      title: "Destination",
                      isCitySelected: true,
                      cities: _listOfCities,
                      icon: Icon(Icons.location_on_outlined),
                    ),
                    TextFormField(
                      controller: dateController,
                      style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        hintText: "Date",
                        prefixIcon: Icon(Icons.date_range),
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        Provider.of<Miscellaneous>(context, listen: false)
                            .bottomModal(context, datePicker());
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 90,
                            child: TextField(
                              style: TextStyle(fontSize: 12),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(Icons.chair),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                              ),
                            )),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isRoundTrip = !isRoundTrip;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: !isRoundTrip
                                ? BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5))
                                : BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Round Trip",
                              style: TextStyle(
                                color:
                                    isRoundTrip ? Colors.white : Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isSearching
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : CButton(
                            "Search",
                            color: Color.fromARGB(172, 61, 90, 254),
                            onTap: () {
                              setState(() {
                                isSearching = true;
                              });
                              String? dep =
                                  context.read<Miscellaneous>().departure;
                              String? des =
                                  context.read<Miscellaneous>().destination;
                              if (dep != null && des != null) {
                                Map data = {
                                  "date": _pickedDate,
                                  "departure": dep,
                                  "destination": des
                                };
                                Provider.of<Request>(context, listen: false)
                                    .searchTrip(context, data)
                                    .then((value) {
                                  setState(() {
                                    isSearching = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SearchScreen(value)));
                                }).catchError((erorr) {
                                  setState(() {
                                    isSearching = false;
                                  });
                                });
                              } else {
                                print("Shit happpended");
                                setState(() {
                                  Provider.of<Miscellaneous>(context,
                                          listen: false)
                                      .scaffoldMessage(
                                          context,
                                          'Please select departure and destination for your trip.',
                                          Colors.redAccent);
                                  isSearching = false;
                                });
                              }
                            },
                          )
                  ],
                ),
              );
            }),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            "Upcoming Trips",
            style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 26, 36, 95),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FutureBuilder<List<GetAllTrip>>(
            future: getAllTrip,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.indigoAccent,
                  ),
                );
              }
              List<GetAllTrip>? trips = snapshot.data;
              return Column(
                  children: trips!.map((trip) => TripView(trip)).toList());
            })
      ],
    );
  }
}
