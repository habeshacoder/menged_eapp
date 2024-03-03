import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mengedegna_app/models/booking.dart';
import 'package:mengedegna_app/models/get_all_cities_model.dart';
import 'package:mengedegna_app/models/get_all_trips.dart';
import 'package:mengedegna_app/models/get_trip_model.dart';
import 'package:mengedegna_app/providers/miscellaneous.dart';
import 'package:provider/provider.dart';
import '../models/user_info_model.dart';
import 'auth.dart';

class Request with ChangeNotifier {
  String backendUrl = 'https://walrus-app-ahi9u.ondigitalocean.app';
  int timeout = 10;
  UserInfoModel? _userInfo;
  //
  List<GetAllCities>? _allCities;
  init(ctx) async {
    await getAllCityStation(ctx);
    await fetchUserDetail(ctx);
  }

  Future fetchUserDetail(context) async {
    Provider.of<Auth>(context, listen: false).checkLogin();
    final url = Uri.parse('$backendUrl/user');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              ' Bearer ${Provider.of<Auth>(context, listen: false).token}',
          'pid': '${Provider.of<Auth>(context, listen: false).pid}',
        },
      );
      print(Provider.of<Auth>(context, listen: false).token);
      print(Provider.of<Auth>(context, listen: false).pid);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        _userInfo = UserInfoModel.fromJson(jsonDecode(response.body));
        notifyListeners();
      }
    } on TimeoutException catch (e) {
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context, 'Network is timedout! please try again.', Colors.red);
      throw 'Network is timedout please try again.';
    } on SocketException catch (e) {
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context,
          'Network is unreachable! Please check your internet connection.',
          Colors.red);
      throw 'Network is unreachable! Please check your internet connection.';
    }
  }

  Future<List<AllCitiesStation>> getAllCityStation(ctx) async {
    final url = Uri.parse('$backendUrl/public/station/all');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((data) => AllCitiesStation.fromJson(data))
            .toList();
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Error Occured!'),
          backgroundColor: Colors.red,
        ));
      }
    } on TimeoutException catch (e) {
      throw 'Network is timedout please try again.';
    } on SocketException catch (e) {
      throw 'Network is unreachable! Please check your internet connection.';
    }
    throw 'Unexpected Error Occured! Please try again.';
  }

  Future<List<GetAllTrip>> searchTrip(context, Map data) async {
    Provider.of<Auth>(context, listen: false).checkLogin();
    var dep = data["departure"];
    var des = data["destination"];
    var date = data["date"];
    final url = Uri.parse(
        '$backendUrl/public/trip-filter-city-date?departure=$dep&destination=$des&date=$date');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['content'];
        print(jsonResponse);
        try {
          return jsonResponse.map((data) => GetAllTrip.fromJson(data)).toList();
        } catch (e) {
          print(e.toString());
        }
      }
    } on TimeoutException catch (e) {
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context, 'Network is timedout! please try again.', Colors.red);
      throw 'Network is timedout please try again.';
    } on SocketException catch (e) {
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context,
          'Network is unreachable! Please check your internet connection.',
          Colors.red);
      throw 'Network is unreachable! Please check your internet connection.';
    }
    throw 'Unexpected Error Occured! Please try again.';
  }

  Future<List<GetAllTrip>> getAllTrips(context) async {
    final url = Uri.parse('$backendUrl/public/trip/all?page=0&size=6');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['content'];
        // print(jsonResponse);
        try {
          return jsonResponse.map((data) => GetAllTrip.fromJson(data)).toList();
        } catch (e) {
          print(e);
          print(e.toString());
        }
      } else {
        Provider.of<Miscellaneous>(context, listen: false)
            .scaffoldMessage(context, 'Error Occured!', Colors.red);
      }
    } on TimeoutException catch (e) {
      throw 'Network is timedout please try again.';
    } on SocketException catch (e) {
      throw 'Network is unreachable! Please check your internet connection.';
    }
    throw 'Unexpected Error Occured! Please try again.';
  }

  Future<GetTrip> getTrip(String tripPID, context) async {
    final url = Uri.parse('$backendUrl/public/trip/$tripPID');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        print(response.body);
        return GetTrip.fromJson(jsonDecode(response.body));
      }
    } on TimeoutException catch (e) {
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context, 'Network is timedout! please try again.', Colors.red);
      throw 'Network is timedout please try again.';
    } on SocketException catch (e) {
      Provider.of<Miscellaneous>(context, listen: false).scaffoldMessage(
          context,
          'Network is unreachable! Please check your internet connection.',
          Colors.red);
      throw 'Network is unreachable! Please check your internet connection.';
    }
    Provider.of<Miscellaneous>(context, listen: false)
        .scaffoldMessage(context, 'Error Occured!', Colors.red);
    throw 'Unexpected Error Occured! Please try again.';
  }

  Future BookTrip(ctx, Map data) async {
    final url = Uri.parse('$backendUrl/booking');
    print(data);
    try {
      final response = await http.post(
        url,
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              ' Bearer ${Provider.of<Auth>(ctx, listen: false).token}',
          'pid': userInfo!.userPublicId as String,
          'agencyPid': data['travelAgencyPID']
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        print(Provider.of<Auth>(ctx, listen: false).token);
        Provider.of<Miscellaneous>(ctx, listen: false)
            .scaffoldMessage(ctx, 'Successfully Booked.', Colors.green);
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Error Occured!'),
          backgroundColor: Colors.red,
        ));
        print(response.statusCode);
        print(response.body);
      }
    } catch (e, stack) {
      print(stack);
      throw e;
    }
  }

  Future<List<BookingModel>> getBooking(ctx) async {
    final url =
        Uri.parse('$backendUrl/booking/all-users?isSelf=true&page=1&size=10');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              ' Bearer ${Provider.of<Auth>(ctx, listen: false).token}',
          'pid': userInfo!.userPublicId as String,
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        List jsonResponse = json.decode(response.body)['content'];
        return jsonResponse.map((data) => BookingModel.fromJson(data)).toList();
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Error Occured!'),
          backgroundColor: Colors.red,
        ));
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
    throw 'Unexpected Error Occured! Please try again.';
  }

  Future deleteBooking(ctx, id) async {
    final url = Uri.parse('$backendUrl/booking/$id');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              ' Bearer ${Provider.of<Auth>(ctx, listen: false).token}',
          'pid': userInfo!.userPublicId as String,
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Successfully canceled.'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Error occured. Unable to cancel your booking.'),
          backgroundColor: Colors.red,
        ));
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Unexpected Error Occured! Please try again.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  List<GetAllCities>? get allCities {
    return _allCities;
  }

  UserInfoModel? get userInfo {
    return _userInfo;
  }
}
