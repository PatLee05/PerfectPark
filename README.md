#### Park Locator App

## Description
Our app completes our 2 goals were one can easily find a park near them in general, and one can filter which parks they want such as finding wheelchair accessibility. Our app uses data give from Places API from google. We also sort the parks based on closest to farthest. Also, each park we list provides its rating, number of ratings given, photo, attributes (if available), and more!

## Support
If one is having any issues with this project, they can email leitoparal@gmail.com for support!

## Contributing

Do the steps listed at "How to build & run the project" before continuing.

We are open to contributions and are excited to see what people come up with! Some rules for contribution:
1. Don't use this app to spread hate.
2. Don't spread misinformation (fact check before adding it to the app).
3. Be respectful of other's contributions.

## Authors and acknowledgment
Front End Author: Patricia Lee
Back End Author: Leonardo Paredes

## Project status
The project is mostly complete.
What we are missing is a decent amount of extra filters to implement for which parks one wants to find.

####
## Spec document given READMEs
###

## How to build & run the project
In order to run the project, one must do these steps in order
1. Get a Google API key at https://console.cloud.google.com/projectselector2/google/maps-apis/credentials?utm_source=Docs_CreateAPIKey&utm_content=Docs_maps-backend. 
2. Run Flutter Pub Get (assuming Flutter and Dart are installed, https://docs.flutter.dev/get-started/install)
3. Add your API key to park_list_checker.dart.
4. Go to 'https://cors-anywhere.herokuapp.com/' to activate the Proxy temporarily
5. Run "flutter run -d chrome --web-renderer html" in order for the application to work with the google images

## Layout of project structure (what files/classes implement what functionality)
We also had weather_checker serve a similar function similar to how weather provider was initialized with the current weather using the weather.gov api
We then also had a location provider which access our device's current location.
Then our views, we had all_parks to have a list of all the parks and show the weather.
park_view was connected to all_views where each tile would send a user to a new page that detailed everything about the parks using our Park data structure.

## Data Design and Data Flow
We created the data structures of Park and Location
Park stored the park name, latitude, longitude, and the park attributes such as wheelchair accessibility.
Location just stored the latitude and longitude of the users current location, this was also stored online on Hive for quick access.

We used park_list_checker to essentially initalize park_list_provider by using the Google Nearby Places API with a proxy to get the JSON data
from the URL given.