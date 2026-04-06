import 'dart:math';

class Park{
    Park({required this.name, 
          required this.latitude, 
          required this.longitude, 
          required this.attributes});
  
    // park name
    final String name;
    // park latitude
    final double latitude;
    // park longitude
    final double longitude;
    // park attribute, with the attribute as the key and the value as the value
    final Map<String, String> attributes;

    // Getters 
    String get parkName {
      return name;
    }
    
    @override
    String toString() {
      return "name: $name, lat: $latitude, lng: $longitude, map: $attributes";
    }

    // finds the distance between two locations using the phytagorean theorem
    double distanceInKilometers( {required double personLatitude, required double personLongitude}) {
    return (111139 * sqrt(squared(latitude - personLatitude) + squared(longitude - personLongitude))).toInt() /1000;
  }

  num squared(num x) {
    return x * x;
  }
}