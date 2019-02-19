import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:slugify2/slugify.dart';

Slugify slugify = new Slugify();

class GeoPoint {
  GeoPoint(
      {@required this.name,
      @required this.position,
      this.placemark,
      this.images})
      : assert(name != null),
        assert(position != null) {
    this.slug = slugify.slugify(name);
    this.timestamp = position.timestamp.millisecondsSinceEpoch;
    this.latitude = position.latitude;
    this.longitude = position.longitude;
    this.altitude = position.altitude;
    this.speed = position.speed;
    this.accuracy = position.accuracy;
    this.speedAccuracy = position.speedAccuracy;
    this.heading = position.heading;
    if (placemark != null) {
      this.number = placemark.subThoroughfare;
      this.street = placemark.thoroughfare;
      this.locality = placemark.locality;
      this.locality = placemark.subLocality;
      this.postalCode = placemark.postalCode;
      this.subregion = placemark.subAdministratieArea;
      this.region = placemark.administrativeArea;
      this.country = placemark.country;
    }
  }

  final String name;
  String slug;
  int timestamp;
  Position position;
  Placemark placemark;
  double latitude;
  double longitude;
  double altitude;
  double speed;
  double accuracy;
  double speedAccuracy;
  double heading;
  String number;
  String street;
  String locality;
  String sublocality;
  String postalCode;
  String subregion;
  String region;
  String country;
  List<File> images;

  get address => _getAddress();

  GeoPoint.fromJson(Map<String, dynamic> json)

      /// build this geopoint from json data
      /// [json] the json data to build from
      : name = json["name"],
        slug = slugify.slugify(json["name"]),
        timestamp = json["timestamp"],
        latitude = json["latitude"],
        longitude = json["longitude"],
        altitude = json["altitude"],
        speed = json["speed"],
        accuracy = json["accuracy"],
        speedAccuracy = json["speed_accuracy"],
        heading = json["heading"],
        number = json["number"],
        street = json["street"],
        locality = json["locality"],
        sublocality = json["sublocality"],
        postalCode = json["postal_code"],
        subregion = json["subregion"],
        region = json["region"],
        country = json["country"];

  Map<String, String> toMap() {
    /// get a json map from this geopoint
    Map<String, String> json = {
      "name": "$name",
      "timestamp": "$timestamp",
      "latitude": "$latitude",
      "longitude": "$longitude",
      "altitude": "$altitude",
      "speed": "$speed",
      "heading": "$heading",
      "accuracy": "$accuracy",
      "speed_accuracy": "$speedAccuracy",
      "number": "$number",
      "street": "$street",
      "locality": "$locality",
      "sublocality": "$sublocality",
      "postal_code": "$postalCode",
      "subregion": "$subregion",
      "region": "$region",
      "country": "$country",
    };
    return json;
  }

  @override
  String toString() {
    /// convert this geopoint to string
    String str = "Geopoint: $name\n";
    str += "Lat: $latitude\n";
    str += "Lon: $longitude\n";
    str += "Altitude: $altitude\n";
    str += "Speed: $speed\n";
    str += "Heading: $heading\n";
    if (placemark != null) {
      str += _getAddress();
    }
    return str;
  }

  String _getAddress() {
    /// get a formated address from this geopoint
    String address = "$number $street $locality ";
    address += "$postalCode $subregion $region $country";
    return address;
  }
}
