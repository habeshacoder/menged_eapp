class GetAllCities {
  GetAllCities({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GetAllCities.fromJson(Map<String, dynamic> json) => GetAllCities(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class AllCitiesStation {
  AllCitiesStation({
    required this.id,
    required this.city,
    required this.station,
    required this.stationPublicId,
  });

  final int id;
  final String city;
  final String station;
  final String stationPublicId;
  factory AllCitiesStation.fromJson(Map<String, dynamic> json) =>
      AllCitiesStation(
          id: json["id"],
          city: json["city"],
          station: json["station"],
          stationPublicId: json["stationPublicId"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "station": station,
        "stationPublicId": stationPublicId
      };
}
