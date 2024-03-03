import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mengedegna_app/models/get_all_trips.dart';
import 'package:mengedegna_app/screens/ticket.dart';
import 'package:mengedegna_app/style/colors.dart';
import 'package:mengedegna_app/style/style.dart';
import 'package:mengedegna_app/widgets/image_hero.dart';
import 'package:provider/provider.dart';

import '../models/get_trip_model.dart';
import '../providers/request.dart';
import 'trip_info.dart';

class SearchedTrips extends StatefulWidget {
  final String searchedDate, origin, destination, adultPassenger;
  const SearchedTrips({
    Key? key,
    required this.searchedDate,
    required this.origin,
    required this.destination,
    required this.adultPassenger,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchedTripsState createState() => _SearchedTripsState();
}

class _SearchedTripsState extends State<SearchedTrips> {
  Future<List<GetAllTrip>>? getAllTrip;

  @override
  void initState() {
    super.initState();
    getAllTrip =
        Provider.of<Request>(context, listen: false).getAllTrips(context);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TitleFont(text: widget.searchedDate),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleFont(
                      text: 'From ${widget.origin} to ${widget.destination}'),
                  TitleFont(text: '${widget.adultPassenger} adult')
                ],
              ),
            ),
            FutureBuilder<List<GetAllTrip>>(
              future: getAllTrip,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<GetAllTrip>? data = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return TripInfo(
                                      tripPID: data![index].tripPublicId);
                                }));
                              },
                              child: _reservationsItem(context, data!, index)),
                          // _reservationsItem('Mabel Travels', '300 Birr'),
                          // _reservationsItem('Galaxy Trip', '400 Birr'),
                          // _reservationsItem('Mola Busses', '200 Birr'),
                          // _reservationsItem('Ahmed Transport Inc.', '375 Birr'),
                        ],
                      );
                    },
                    itemCount: data!.length,
                  );
                }
                return SizedBox(
                  height: deviceSize.height * 0.5,
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _reservationsItem(
    BuildContext context, List<GetAllTrip> data, int index) {
  return Card(
    elevation: 12,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(15), bottom: Radius.circular(15)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: 60,
                  child: const Image(
                    image: AssetImage('assets/bus_logo.png'),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Align(
                  alignment: Alignment.center,
                  child: TitleFont(
                    text: data[index].travelAgency.name,
                    size: 22,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ImageHero(
                  photo: data[index].bus.imageUrl,
                  width: 60,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return ImageHero(
                        photo: data[index].bus.imageUrl,
                        width: double.infinity,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        plateNumber: data[index].bus.license,
                        driverName: data[index].driver.user.firstName,
                      );
                    }));
                  },
                ),

                // Container(
                //   width: 60,
                //   child:
                //    Image(
                //     image: NetworkImage(data[index].bus.imageUrl),
                //   ),
                // ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: _itemDepartment(data[index].departureTime,
                    data[index].route.departureAddress.city),
              ),
              Expanded(flex: 6, child: _locationPlane(data[index].price)),
              Expanded(
                flex: 2,
                child: _itemDepartment2(data[index].arrivalTime,
                    data[index].route.destinationAddress.city),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget _itemDepartment(String departureTime, String origin) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Departure",
          style: TextStyle(color: Color.fromARGB(255, 36, 35, 35))),
      const SizedBox(height: 10),
      Text(departureTime,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: 1),
      Text(
        origin,
        style: const TextStyle(color: Colors.black54),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ],
  );
}

Widget _itemDepartment2(String arrivalTime, String destination) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      const Text("Arrive",
          style: TextStyle(color: Color.fromARGB(255, 36, 35, 35))),
      const SizedBox(height: 10),
      Text(arrivalTime,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: 1),
      Text(
        destination,
        style: const TextStyle(color: Colors.black54),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ],
  );
}

Widget _locationPlane(double price) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.location_on,
              color: Color.fromARGB(255, 172, 67, 7), size: 21),
          Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
          Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
          Icon(Icons.directions_bus,
              color: Color.fromARGB(255, 13, 170, 8), size: 21),
        ],
      ),
      const SizedBox(height: 10),
      DescriptionFont(
        text: '$price Birr',
        size: 20,
        fontWeight: FontWeight.bold,
      )

      // Row(
      //   children: [
      //     ElevatedButton(
      //         onPressed: () {},
      //         child: const Text(
      //           "Print Ticket",
      //           style: TextStyle(color: Colors.black),
      //         ))
      //   ],
      // )
    ],
  );
}
