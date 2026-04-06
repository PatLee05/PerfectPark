import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:park_locator/models/park.dart';
import 'package:park_locator/provider/park_list_provider.dart';

class ParkListChecker {
  final ParkListProvider parkListProvider;
  String apiKey = 'API KEY HERE';
  String herokuProxyUrl = 'https://cors-anywhere.herokuapp.com/';

  ParkListChecker(this.parkListProvider);

  fetchAndUpdateCurrentParkListNearLocation() async {
    // ONLY run if isLocationReady returns TRUE
    try {
      List<String> placeIdList = await getNearbyParks();

      print("PlaceIdList successfully obtained");
      // ADDING PARK LIST DETAILS
      for (var placeId in placeIdList) {
        final newPark = await getParkFromPlaceID(placeId: placeId);
        parkListProvider.addUniquePark(newPark);
      }
      parkListProvider.setIsParkListReady(true);

    } catch (e) {
      throw Exception('ParkListChecker: fetchAndUpdateCurrentParkListNearLocation: ERROR \n$e');
    }

    // ONLY run if isLocationReady returns TRUE
  }

  ////Future<Map<String, dynamic>>
  Future<List<String>> getNearbyParks() async {
    const meterRadius = 15000;
    final lat = parkListProvider.getLat();
    final lng = parkListProvider.getLng();

    var client = http.Client();
    final url = '${herokuProxyUrl}https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=$lat,$lng'
      '&type=park'
      '&radius=$meterRadius'
      '&key=$apiKey';
    
    try {
      final gridResponse = await client.get(Uri.parse(url)); 
      final gridParsed = (jsonDecode(gridResponse.body));
      final List<dynamic> resultsArr = gridParsed['results'];

      List<String> placeIdList= [];
      for (dynamic currParkInfo in resultsArr) {
        String currPlaceId = currParkInfo['place_id'];
        placeIdList.add(currPlaceId);
      }
      return placeIdList;
    } catch(e) {
      throw Exception('ParkListChecker: getNearbyParks: ERROR\n$e');
    } finally {
      client.close();
    }
  }

  Future<Park> getParkFromPlaceID({required String placeId}) async {
    var client = http.Client();
    final url = '${herokuProxyUrl}https://maps.googleapis.com/maps/api/place/details/json'
      '?fields=wheelchair_accessible_entrance,user_ratings_total,rating,geometry,name,photos,formatted_address,editorial_summary,website,current_opening_hours'
      '&place_id=$placeId'
      '&key=$apiKey';
    
    try {
      final gridResponse = await client.get(Uri.parse(url));
      final gridParsed = (jsonDecode(gridResponse.body));
      final result = gridParsed['result'];

      final photoReference = result['photos']?[0]?['photo_reference'];

      final name = result['name'];
      final lat = result['geometry']?['location']?['lat'];
      final lng = result['geometry']?['location']?['lng'];

      // // Park List<String> Attributes:
      Map<String, String> attr = {};
      // gets the park photo url
      attr['photoURL'] = getPhotoURLFromPhotoReference(photoReference);

      // checks if the park is wheelchair accessible
      bool accessible = result['wheelchair_accessible_entrance'] ?? false;
      attr['wheelchairAccessibleEntrance'] = accessible.toString();

      // gets the number of Google user reviews/ratings about the park
      attr['userRatingsTotal'] = result['user_ratings_total'].toString();
      // gets the park rating out of 5
      attr['rating'] = result['rating'].toString();
      // gets the park address
      attr['address'] = result['formatted_address'].toString();
      // gets the park website
      attr['website'] = result['website'].toString();

      // gets the overview of the park
      String? sum = result['editorial_summary']?['overview'].toString();
      attr['summary'] = sum ?? '';
      // checks whether or not the park is open now
      bool openNow = result['current_opening_hours']?['open_now'] ?? false;
      attr['openNow'] = openNow.toString();

      Park newPark = Park(name: name, latitude: lat, longitude: lng, attributes: attr);
      
      return newPark;
    } catch(e) {
      throw Exception('ParkListChecker: getParkDetailsFromPlaceId: ERROR\n$e');
    } finally {
      client.close();
    }
  }

  // MUST be String? since it can be null!
  String getPhotoURLFromPhotoReference(String? photoReference) {
    String photoURL = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference='
      '$photoReference&key=$apiKey'; 
    return photoURL;
  }
}