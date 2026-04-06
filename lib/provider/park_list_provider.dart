import 'package:flutter/material.dart';
import 'package:park_locator/models/park.dart';
import 'package:hive/hive.dart';

import '../models/location.dart';


class ParkListProvider extends ChangeNotifier {
  final Box<Location> _locationBox;

  List<Park> _parkList;
  // The person's latitude
  String _latitude;
  // The person's longitude
  String _longitude;
  bool _isParkListReady;
  
  ParkListProvider({required Box<Location> locBox}) 
    : _parkList = [], 
    _locationBox = locBox,
    _latitude = (locBox.isNotEmpty) ? locBox.get('location')!.latitude : '1.0', 
    _longitude = (locBox.isNotEmpty) ? locBox.get('location')!.longitude : '1.0', 
    _isParkListReady = false;

  //// Getters & Setters
  String getLat() => _latitude;
  String getLng() => _longitude;
  bool getIsParkListready() => _isParkListReady;

  setIsParkListReady(bool status) {
    _isParkListReady = status;
  }

  updateLocation({required double newLatitude, required double newLongitude}) {
    if (newLatitude.toString() != '0.0' && newLatitude.toString() != '1.0') {
      print('ParkListProvider updateLocation called');
      _latitude = newLatitude.toString();
      _longitude = newLongitude.toString(); 
      _locationBox.put('location', Location(_latitude, _longitude)); // IMPORTANT ORDER!!
      notifyListeners();
    }
  }

  List<Park> getParkListClone() {
    return List.from(_parkList);
  }

  List<Park> getOrderedParkListClone() {
    const max = 99;
    List<Park> parkListCopy = List.from(_parkList);
    
    parkListCopy.sort((a, b) {
      double distA = a.distanceInKilometers(personLatitude: double.parse(_latitude), personLongitude: double.parse(_longitude));
      double distB = b.distanceInKilometers(personLatitude: double.parse(_latitude), personLongitude: double.parse(_longitude));


      int diff = ((distA - distB) < 0) ? -1 : 1;
      return diff;
    });

    return parkListCopy.take(max).toList();
  }

  //// General Methods
  addUniquePark(Park newPark) {
    // .contains is not enough, parkName should be unique
    bool parkExists = _parkList.any((park) => park.name == newPark.name);
    if (!parkExists) {
      _parkList.add(newPark);
    }
  }
}