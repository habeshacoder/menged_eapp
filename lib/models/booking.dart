import 'package:mengedegna_app/models/get_trip_model.dart';
import 'package:mengedegna_app/models/user_info_model.dart';

class BookingModel {
  BookingModel({
    required this.bookingPublicId,
    required this.user,
    required this.travelAgency,
    required this.travelerInfo,
    required this.trip,
    required this.date,
    required this.isAgent,
    required this.isSelf,
    // required this.questionsAndAnswers,
  });

  String bookingPublicId;
  UserInfoModel? user;
  TravelAgency? travelAgency;
  TravelerInfo? travelerInfo;
  String? date;
  GetTrip? trip;
  bool isAgent;
  bool isSelf;
  // List<String> questionsAndAnswers;

  factory BookingModel.fromJson(json) => BookingModel(
        bookingPublicId: json["bookingPublicId"],
        user:
            json["user"] != null ? UserInfoModel.fromJson(json["user"]) : null,
        travelAgency: json["travelAgency"] != null
            ? TravelAgency.fromJson(json["travelAgency"])
            : null,
        travelerInfo: json["travelerInfo"] != null
            ? TravelerInfo.fromJson(json["travelerInfo"])
            : null,
        date: json["date"],
        trip: json["trip"] != null ? GetTrip.fromJson(json["trip"]) : null,
        isSelf: json["isSelf"],
        isAgent: json["isAgent"],
        // questionsAndAnswers:
        //     List<String>.from(json["questionsAndAnswers"].map((x) => x)),
      );

  toJson() => {
        "userPublicId": bookingPublicId,
        "user": user,
        "travelAgency": travelAgency,
        "travelerInfo": travelerInfo,
        "date": date,
        "trip": trip,
        "isSelf": isSelf,
        "isAgent": isAgent,
        // "questionsAndAnswers":
        //     List<dynamic>.from(questionsAndAnswers.map((x) => x)),
      };
}

class TravelerInfo {
  TravelerInfo({
    required this.id,
    required this.passengerName,
    required this.passengerAddress,
  });

  final int id;
  final String? passengerName;
  final String? passengerAddress;

  factory TravelerInfo.fromJson(json) => TravelerInfo(
        id: json["id"],
        passengerName: json["passengerName"],
        passengerAddress: json["passengerAddress"],
      );

  toJson() => {
        "id": id,
        "passengerName": passengerName,
        "passengerAddress": passengerAddress,
      };
}
