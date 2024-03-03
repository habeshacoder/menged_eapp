class GetTrip {
  GetTrip({
    required this.id,
    required this.tripPublicId,
    required this.date,
    required this.departureTime,
    required this.arrivalTime,
    required this.numberOfTicket,
    required this.price,
    required this.travelAgency,
    required this.bus,
    required this.driver,
    required this.route,
    required this.gracePeriod,
    required this.tripStatus,
  });

  final int id;
  final String? tripPublicId;
  final DateTime date;
  final String? departureTime;
  final String? arrivalTime;
  final String? numberOfTicket;
  final double price;
  final TravelAgency? travelAgency;
  final Bus? bus;
  final Driver? driver;
  final Route? route;
  final int gracePeriod;
  final dynamic tripStatus;

  factory GetTrip.fromJson(Map<String, dynamic> json) => GetTrip(
        id: json["id"],
        tripPublicId: json["tripPublicId"],
        date: DateTime.parse(json["date"]),
        departureTime: json["departureTime"],
        arrivalTime: json["arrivalTime"],
        numberOfTicket: json["numberOfTicket"],
        price: json["price"],
        travelAgency: json["travelAgency"] != null
            ? TravelAgency.fromJson(json["travelAgency"])
            : null,
        bus: json["bus"] != null ? Bus.fromJson(json["bus"]) : null,
        driver: json["driver"] != null ? Driver.fromJson(json["driver"]) : null,
        route: json["route"] != null ? Route.fromJson(json["route"]) : null,
        gracePeriod: json["gracePeriod"],
        tripStatus: json["tripStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tripPublicId": tripPublicId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "departureTime": departureTime,
        "arrivalTime": arrivalTime,
        "numberOfTicket": numberOfTicket,
        "price": price,
        "travelAgency": travelAgency!.toJson(),
        "bus": bus!.toJson(),
        "driver": driver!.toJson(),
        "route": route!.toJson(),
        "gracePeriod": gracePeriod,
        "tripStatus": tripStatus,
      };
}

class Bus {
  Bus({
    required this.id,
    required this.busPublicId,
    required this.travelAgency,
    required this.name,
    required this.model,
    required this.license,
    required this.numberOfSeats,
    required this.imageUrl,
    required this.color,
  });

  final int id;
  final String? busPublicId;
  final TravelAgency? travelAgency;
  final String? name;
  final String? model;
  final String? license;
  final String? numberOfSeats;
  final String? imageUrl;
  final String? color;

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        id: json["id"],
        busPublicId: json["busPublicId"],
        travelAgency: TravelAgency.fromJson(json["travelAgency"]),
        name: json["name"],
        model: json["model"],
        license: json["license"],
        numberOfSeats: json["numberOfSeats"],
        imageUrl: json["imageUrl"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "busPublicId": busPublicId,
        "travelAgency": travelAgency!.toJson(),
        "name": name,
        "model": model,
        "license": license,
        "numberOfSeats": numberOfSeats,
        "imageUrl": imageUrl,
        "color": color,
      };
}

class TravelAgency {
  TravelAgency({
    required this.id,
    required this.name,
    required this.email,
    required this.agencyPublicId,
    required this.address,
    required this.description,
    required this.profileImageUrl,
    required this.owner,
    required this.drivers,
    required this.buses,
    required this.trips,
    required this.isApproved,
  });

  final int id;
  final String? name;
  final String? email;
  final String? agencyPublicId;
  final List<Address>? address;
  final String? description;
  final String? profileImageUrl;
  final User? owner;
  final List<dynamic> drivers;
  final List<dynamic> buses;
  final List<dynamic> trips;
  final bool isApproved;

  factory TravelAgency.fromJson(Map<String, dynamic> json) => TravelAgency(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        agencyPublicId: json["agencyPublicId"],
        address: json["address"] != null
            ? List<Address>.from(
                json["address"].map((x) => Address?.fromJson(x)))
            : null,
        description: json["description"],
        profileImageUrl: json["profileImageUrl"],
        owner: User?.fromJson(json["owner"]),
        drivers: List<dynamic>.from(json["drivers"].map((x) => x)),
        buses: List<dynamic>.from(json["buses"].map((x) => x)),
        trips: List<dynamic>.from(json["trips"].map((x) => x)),
        isApproved: json["isApproved"],
      );

  Map<String, dynamic>? toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "agencyPublicId": agencyPublicId,
        "address": List<dynamic>.from(address!.map((x) => x.toJson())),
        "description": description,
        "owner": owner?.toJson(),
        "profileImageUrl": profileImageUrl,
        "drivers": List<dynamic>.from(drivers.map((x) => x)),
        "buses": List<dynamic>.from(buses.map((x) => x)),
        "trips": List<dynamic>.from(trips.map((x) => x)),
        "isApproved": isApproved,
      };
}

class Address {
  Address({
    required this.id,
    required this.street,
    required this.city,
  });

  final int id;
  final String? street;
  final String? city;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        street: json["street"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "street": street,
        "city": city,
      };
}

class User {
  User({
    required this.id,
    required this.userName,
    required this.passWord,
    required this.roles,
    required this.createdOn,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userPublicId,
    required this.address,
    required this.locked,
    required this.enabled,
  });

  final int id;
  final String? userName;
  final String? passWord;
  final List<Role>? roles;
  final DateTime createdOn;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? userPublicId;
  final Address? address;
  final bool locked;
  final bool enabled;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["userName"],
        passWord: json["passWord"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        createdOn: DateTime.parse(json["createdOn"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        userPublicId: json["userPublicId"],
        address: Address.fromJson(json["address"]),
        locked: json["locked"],
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "passWord": passWord,
        "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
        "createdOn": createdOn.toIso8601String(),
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "userPublicId": userPublicId,
        "address": address!.toJson(),
        "locked": locked,
        "enabled": enabled,
      };
}

class Role {
  Role({
    required this.id,
    required this.name,
  });

  final int id;
  final String? name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Driver {
  Driver({
    required this.id,
    required this.driverPublicId,
    required this.user,
    required this.travelAgency,
    required this.yearsOfExperience,
    required this.profileImageUrl,
    required this.description,
  });

  final int id;
  final String? driverPublicId;
  final User? user;
  final TravelAgency? travelAgency;
  final String? yearsOfExperience;
  final String? profileImageUrl;
  final String? description;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        driverPublicId: json["driverPublicId"],
        user: User.fromJson(json["user"]),
        travelAgency: TravelAgency.fromJson(json["travelAgency"]),
        yearsOfExperience: json["yearsOfExperience"],
        profileImageUrl: json["profileImageURL"],
        description: json["description"],
      );

  Map<String, dynamic>? toJson() => {
        "id": id,
        "driverPublicId": driverPublicId,
        "user": user!.toJson(),
        "travelAgency": travelAgency!.toJson(),
        "yearsOfExperience": yearsOfExperience,
        "profileImageURL": profileImageUrl,
        "description": description,
      };
}

class Route {
  Route({
    required this.id,
    required this.routePublicId,
    required this.departureAddress,
    required this.intervalAddress,
    required this.destinationAddress,
  });

  final int id;
  final String? routePublicId;
  final DepartureAddressClass? departureAddress;
  final List<IntervalAddress>? intervalAddress;
  final DepartureAddressClass? destinationAddress;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        routePublicId: json["routePublicId"],
        departureAddress:
            DepartureAddressClass.fromJson(json["departureAddress"]),
        intervalAddress: List<IntervalAddress>.from(
            json["intervalAddress"].map((x) => IntervalAddress.fromJson(x))),
        destinationAddress:
            DepartureAddressClass.fromJson(json["destinationAddress"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "routePublicId": routePublicId,
        "departureAddress": departureAddress!.toJson(),
        "intervalAddress":
            List<dynamic>.from(intervalAddress!.map((x) => x.toJson())),
        "destinationAddress": destinationAddress!.toJson(),
      };
}

class DepartureAddressClass {
  DepartureAddressClass({
    required this.id,
    required this.stationPublicId,
    required this.city,
    required this.station,
  });

  final int id;
  final String? stationPublicId;
  final String? city;
  final String? station;

  factory DepartureAddressClass.fromJson(Map<String, dynamic> json) =>
      DepartureAddressClass(
        id: json["id"],
        stationPublicId: json["stationPublicId"],
        city: json["city"],
        station: json["station"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stationPublicId": stationPublicId,
        "city": city,
        "station": station,
      };
}

class IntervalAddress {
  IntervalAddress({
    required this.id,
    required this.sequence,
    required this.stopPlace,
  });

  final int id;
  final int sequence;
  final String? stopPlace;

  factory IntervalAddress.fromJson(Map<String, dynamic> json) =>
      IntervalAddress(
        id: json["id"],
        sequence: json["sequence"],
        stopPlace: json["stopPlace"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sequence": sequence,
        "stopPlace": stopPlace,
      };
}
