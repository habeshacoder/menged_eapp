import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mengedegna_app/style/colors.dart';
import 'package:mengedegna_app/style/style.dart';
import 'package:provider/provider.dart';

import '../models/get_trip_model.dart';
import '../providers/request.dart';

class TripInfo extends StatefulWidget {
  final String tripPID;
  const TripInfo({Key? key, required this.tripPID}) : super(key: key);

  @override
  State<TripInfo> createState() => _TripInfoState();
}

class _TripInfoState extends State<TripInfo> {
  Future<GetTrip>? getTrip;
  bool expanded = true;

  @override
  void initState() {
    getTrip = Provider.of<Request>(context, listen: false)
        .getTrip(widget.tripPID, context);
    super.initState();
  }

  void changed() {
    setState(() {
      expanded == true ? expanded = false : expanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<GetTrip>(
            future: getTrip,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                GetTrip? data = snapshot.data;
                return SingleChildScrollView(
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                          bottom: Radius.circular(15)),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data!.travelAgency!.name as String),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const DescriptionFont(
                                  text: 'Departure City',
                                  size: 10,
                                  color: AppColors.grey,
                                ),
                                TitleFont(
                                  text: data.route!.departureAddress!.city
                                      as String,
                                  size: 20,
                                  color: AppColors.black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const DescriptionFont(
                                  text: 'Departure Time',
                                  size: 10,
                                ),
                                TitleFont(
                                  text: data.departureTime as String,
                                  size: 20,
                                  color: AppColors.black,
                                ),
                              ],
                            )
                          ],
                        ),
                        ExpansionTile(
                          onExpansionChanged: (value) => changed(),
                          title: TitleFont(
                            text: expanded
                                ? 'Tap here for more details'
                                : 'Tap here to minimize',
                            color: AppColors.primary,
                          ),
                          children: [
                            const SizedBox(
                              height: 250,
                            ),
                            Text(data.bus!.name as String)
                          ],
                        )
                      ]),
                    ),
                  ),
                );
              }
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.black,
                  size: 40,
                ),
              );
            }),
      ),
    );
  }
}
