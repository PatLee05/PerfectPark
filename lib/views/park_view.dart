import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/models/park.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ParkView extends StatelessWidget {
  // the park chosen by the user
  final Park park;

  const ParkView({super.key, required this.park});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Color.fromARGB(255, 230, 225, 219)
          ), 
          title: Text(
            park.name, 
            style: const TextStyle(
              color: Color.fromARGB(255, 230, 225, 219),
              fontWeight: FontWeight.bold,
            ),
            semanticsLabel: park.name,
          ),
          backgroundColor: const Color.fromARGB(255, 74, 61, 55),
        ),
        body: Scaffold(
          backgroundColor: const Color.fromARGB(255, 230, 225, 219),
          body: Center(
            child: Column(children: [
              
              // Prints the park name 
              // I made it selectable in case the user wants to search it up
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SelectableText(
                  park.name,
                  semanticsLabel: 'Park name: ${park.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
          
              // Prints the park address
              // Made it selectable so that the user can copy and paste the address easily to a map app
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Address: ${park.attributes['address']}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              // Shows the user if the park is open now or not
              Padding( 
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (park.attributes['openNow'] == 'true' ? 'Open Now' : ''),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          
              // Display picture
              Column(
                children: [
          
                  // Display the park image
                  Semantics(
                    label: 'Image of ${park.name}',
                    child: Image.network(
                      park.attributes['photoURL']!,
                      scale: 1.2,
                    ),
                  ),
        
                  // Prints an editorial summary of the park, given by Google Places API
                  // Also shows if the park is wheelchair accessible or not
                  Padding( 
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${park.attributes['summary']} ${(park.attributes['wheelchairAccessibleEntrance'] == 'true' ? 'Wheelchair accessible.' : '')}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),

                  // Displays the park rating from Google users
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Park Rating: ${park.attributes['rating']}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
          
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      '(out of ${park.attributes['userRatingsTotal']} user ratings on Google Maps)',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),

                  // Added a hyperlink to the park's official website
                  // Incase the user wants to know more
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'To learn more, check its '),
                          TextSpan(
                              text: 'website',
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrlString('${park.attributes['website']}');
                                }),
                          const TextSpan(text: '!'),
                        ],
                      ),
                    ),
                  ),
                ]
              ),
            ]),
          ),
        ));
  }
}
