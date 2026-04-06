import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:park_locator/helper/weather_checker.dart';
import 'package:park_locator/helper/weather_condition.dart';
import 'package:park_locator/models/park.dart';
import 'package:park_locator/provider/location_provider.dart';
import 'package:park_locator/provider/park_list_provider.dart';
import 'package:park_locator/provider/weather_provider.dart';
import 'package:park_locator/helper/park_list_checker.dart';
import 'package:park_locator/views/park_view.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';

class AllParks extends StatefulWidget {
  const AllParks({super.key});

  @override
  State<AllParks> createState() => _AllParksState();
}

class _AllParksState extends State<AllParks> {
  // the attributes that the users can filter
  List<String> variantsList = [
    'Open Now',
    'Wheelchair Accessible'
  ];
  
  // to keep the selected filters
  List<String> selectedCheckBoxValue = [];

  // store the list of parks that satisfies the filter
  List<Park> selectedParks = [];

  late final WeatherChecker _weatherChecker;
  late final ParkListChecker _parkListChecker;

  late final Timer checkerTimer;
  late final Timer _parkListCheckerTimer;

  // show the weather condition using an icon
  // uses a default icon if the weather condition is unknown
  late Icon weatherIcon = const Icon(Icons.park);

  // shows the current temperature
  int temp = 0;

  @override
  void initState() {
    super.initState();

    // Setting up parkListChecker
    // #### ParkList Provider ####
    final singleUseParkListProvider = Provider.of<ParkListProvider>(context, listen: false);

    _parkListChecker = ParkListChecker(singleUseParkListProvider);
    // calls the park list first so we don't have to wait too long
    _parkListChecker.fetchAndUpdateCurrentParkListNearLocation();

    // updates the park list every 10 seconds
    _parkListCheckerTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _parkListChecker.fetchAndUpdateCurrentParkListNearLocation();
    });

    // #### Weather Provider ####
    // checks the weather condition
    WeatherProvider weatherProvider = Provider.of<WeatherProvider>(context, listen: false);

    // calls the weather checker
    _weatherChecker = WeatherChecker(weatherProvider);
    // calls the weather first so we don't have to wait too long
    _weatherChecker.fetchAndUpdateCurrentSeattleWeather();

    // updates the weather every 10 seconds
    checkerTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _weatherChecker.fetchAndUpdateCurrentSeattleWeather();

      setState(() {
        // set the weather icon according to the weather condition
       if (weatherProvider.condition == WeatherCondition.gloomy) {
          weatherIcon = const Icon(WeatherIcons.cloudy, semanticLabel: 'cloudy icon',);
        } else if (weatherProvider.condition == WeatherCondition.rainy) {
          weatherIcon = const Icon(WeatherIcons.rain, semanticLabel: 'rainy icon',);
        } else {
          weatherIcon = const Icon(WeatherIcons.day_sunny, semanticLabel: 'sunny icon',);
        }

        // set the temperature
        temp = weatherProvider.tempInFarenheit;
      });
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // the top appbar
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Park Locator',
          style: TextStyle(
            // used a light color since the appbar background is a dark chocolate color
            color: Color.fromARGB(255, 230, 225, 219),
            // used a bold font so that it stands out more
            fontWeight: FontWeight.bold,
          ),
          semanticsLabel: 'Park Locator',
        ),

        actions: <Widget>[
          // shows the user the current temperature
          Text(
            'Temperature: $temp °F',
            style: const TextStyle(
              color: Color.fromARGB(255, 230, 225, 219),
            ),
          ),
          // shows the user the current weather condition in their location using an icon
          IconButton(
            icon: weatherIcon,
            onPressed: () {},
            color: const Color.fromARGB(255, 230, 225, 219),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
          ),
        ],

        backgroundColor: const Color.fromARGB(255, 74, 61, 55),
      ),

      body: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 225, 219),
        body: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // create a dropdown checkbox for the users to filter the park attributes
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Semantics(
                      label: 'Dropdown menu',
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 100, 
                        padding: const EdgeInsets.all(20),
                        // use an imported package for a checkbox that allows for multiple selections
                        child: DropDownMultiSelect(
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.onPrimary,
                            focusColor: Theme.of(context).colorScheme.onPrimary,
                            enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 74, 61, 55),
                                  width: 1.5,
                                )),
                          ),
                          options: variantsList,
                          selectedValues: selectedCheckBoxValue,
                          onChanged: (List<String> value) {
                            setState(() {
                              selectedCheckBoxValue = value;                        
                            });
                          },
                          separator: ', ',
                          whenEmpty: 'Select Attribute',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // park list
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child:
                                Consumer2<ParkListProvider, LocationProvider>(
                                    builder: (context, parkListProvider, locationProvider, child) {
                              // The instant the position is known, _parkListChecker gets the parkList so as to not rely on the 30 seconds
                              if (locationProvider.isPositionKnown) {
                                parkListProvider.updateLocation(newLatitude: locationProvider.latitude, newLongitude: locationProvider.longitude);

                                // if the user does not use the filtering system, show all the parks
                                if (selectedCheckBoxValue.isEmpty) {
                                  return ListView.builder(
                                    itemCount: parkListProvider.getParkListClone().length,
                                    itemBuilder: (context, index) {
                                      final parkEntry = parkListProvider.getOrderedParkListClone()[index];
                                      return _createParkListView(
                                        context, parkEntry,
                                        myLatitude: locationProvider.latitude,
                                        myLongitude: locationProvider.longitude
                                      );
                                    },
                                  );
                                } else {
                                  // if the users uses the filtering system, show only the parks that satisfies the selected attributes
                                  List<String> selectedAttributes = [];

                                  // change the text to fit the key value of the attributes map
                                  for (int x = 0; x < selectedCheckBoxValue.length; x++) {
                                    if (selectedCheckBoxValue[x] == 'Open Now') {
                                      selectedAttributes.add('openNow');
                                    } else if (selectedCheckBoxValue[x] == 'Wheelchair Accessible') {
                                      selectedAttributes.add('wheelchairAccessibleEntrance');
                                    }
                                  }

                                  // get the park list clone
                                  List<Park> temp = parkListProvider.getOrderedParkListClone();
                                  
                                  // reset the selected parks so that previous filtering usage does not affect the next ones
                                  selectedParks = [];

                                  for (int i = 0; i < temp.length; i++) {
                                    Park currPark = temp[i];
                                    bool satisfiesAllAttributes = true;
                                    
                                    // if a park does not satisfy all of the attribute selected, it will not be added into the list of selectedParks
                                    for (int j = 0; j < selectedAttributes.length; j++) {
                                      String attribute = selectedAttributes[j];
                                      if (currPark.attributes[attribute] != 'true') {
                                        satisfiesAllAttributes = false;
                                        break;
                                      }
                                    }

                                    if (satisfiesAllAttributes) {
                                      // Unique add park
                                      bool parkExists = selectedParks.any((park) => park.name == currPark.name);
                                      if (!parkExists) {
                                        selectedParks.add(currPark);
                                      }
                                    }
                                  }
                                  
                                  // create a new list using only the selected parks
                                  return ListView.builder(
                                    itemCount: selectedParks.length,
                                    itemBuilder: (context, index) {
                                      final parkEntry = selectedParks[index];
                                      return _createParkListView(context, parkEntry, myLatitude: locationProvider.latitude, myLongitude: locationProvider.longitude);
                                    },
                                  );
                                }
                              }
                              // LOADING CIRCLE
                              else {
                                return _createLoadingCircle();
                              }
                            }),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // create a park list view using ListTile
  Widget _createParkListView(BuildContext context, Park park, {required double myLatitude, required double myLongitude}) {

    // get the distance of the park from the user in kilometers
    double dist = park.distanceInKilometers(personLatitude: myLatitude, personLongitude: myLongitude);

    return Card(
      child: Semantics(
        child: ListTile(
          // Display park photo
          leading: Image.network(
                    park.attributes['photoURL']!,
                    scale: 1.5,
                  ),
          // Display park name
          title: Text(park.name,), 
          // Display park distance to user
          subtitle: Text('Distance: $dist km'), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.black),
          ),
          tileColor: const Color.fromARGB(255, 41, 81, 53),
          textColor: const Color.fromARGB(255, 226, 244, 210),
          // if the user taps on the park, it takes the user to a page that has the park details
          onTap: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => ParkView(park: park)),
            );
          },
        ),
      ),
    );
  }

  // creates a loading circle
  // to be used if the program hasn't gotten the park list yet
  // so that the user knows that something is happening
  Widget _createLoadingCircle() {
    return const Center(
      child: SizedBox(
        width: 75,
        height: 75,
        child: CircularProgressIndicator(
            semanticsLabel: 'Circular Progress Indicator',
            strokeWidth: 10.0,
            color: Colors.blue),
      ),
    );
  }
}