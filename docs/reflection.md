### Course topics
Identify which of the course topics you applied (e.g. secure data persistence) and describe how you applied them.

Answer: We applied these 6 course topics:

- Properties of People: Vision
    We carefully chose colors that are high in contrast with each other, to make it easier for people to read. We also use a font size of 14 pt or higher, which exceeds the WCAG minimum of 12 pt font size. 

- Properties of People: Motor Control (e.g. Fitts's Law)
    We made our back button large enough so that people can press it easily. It is also far away from any clickable content, so people don't accidentally click the wrong button. We also used a ListTile to display the list of parks. 

- Stateless & stateful widgets
    We made our "All-parks" view stateful since we knew there would be changes within the dropdown menu but also within the changing list of parks. For our park_view, it is a set park with set details so it was stateless.

- Accessing sensors (force, GPS, etc.)
    We used Geolocator to get the user's live location. It also updates every 10 seconds, essentially acting as a GPS.

- Querying web services
    We queried Weather.gov and used the Google Places API. Weather.gov gives us the current weather condition, to display to the user. We filled our park list using Google's database. The park details are also taken from Google.

- Secure data persistence
    We used the HIVE and SECURE STORAGE packages in order to implement the secure data persistence. We took our code from Journal Part 2 in order to do this, and modified it a bit in order to work with our different
    data structures. 

### Changes
Describe what changed from your original concept to your final implementation? Why did you make those changes from your original design vision?

Answer: Our original concept involves having bookmarks so that the users can save their favorite parks. We also discussed having a short entry where the user can write their thoughts/notes about the park and rate it according to their own experiences. However, we didn't decide to do either because we ran out of time. Implementing the Google Places API took longer than we thought since we had to connect it with a proxy. After implementation, we decided to just focus on the required things. We also had limited work, since our team only consists of 2 members. 

### Understanding
Discuss how doing this project challenged and/or deepened your understanding of these topics.

Answer: 
This deepened our understanding greatly on the topics of "Querying web services", "Secure data persistence", and "Accessing sensors"
We were able to delve very deeply into query Google API ourselves instead of relying on given code. We were able to review our knowledge 
of data persistence with Hive and Secure Storage. We also were able to review the code which accessed our location and using that location in many aspects of our project

For the topics of Properties of people: Vision, we learned a bit more about our specific beige and black template for the contrast.
For the topic of Properties of people: Motor Control, we learned a bit more about the good general tips to make our buttons more easily usuable.
For the stateful and stateless widgets we reviewed a bit about when to use and not use stateful/stateless widgets depending on changing/unchanging data.


### Future work
Describe two areas of future work for your app, including how you could increase the accessibility and usability of this app.

Answer: 
(1) Add more attributes that the users can filter
According to our SUS testing participants, a lot of them think that there should be more attributes to the filter. Some of the more common ones are to check if there is a restroom and check if theres a playground. I do think that with time and with a larger database, we could expand the app to include those attributes and more. I know that the new Google Places API has those database, however, we checked and it costs money to even access it, so we decided not to.

(2) Add a search bar
Our SUS testing participants commented on how the app seems very simple and would appreciate more features implemented. One participant said to me to implement a search bar. Unfortunately, we don't have the time to do so, but it is something we prioritize when we expand this app. By adding a search bar feature, it eliminates the user from having to scroll all the way to their desired park, especially if they don't know the distance of the park.

### Citations
Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.
Remember to include all online resources such as Stack Overflow, blogs, students in this class, or TAs and instructors who helped you during OH.

Answer:
https://mobikul.com/multiselect-checkbox-inside-dropdown-in-flutter/
https://developers.google.com/maps/documentation/places/web-service/details
https://developers.google.com/maps/documentation/places/web-service/search-nearby
https://developers.google.com/maps/documentation/places/web-service/supported_types
https://stackoverflow.com/questions/73188276/xmlhttprequest-error-on-http-request-to-google-api-in-flutter
https://api.flutter.dev/flutter/dart-convert/jsonDecode.html
https://github.com/Rob--W/cors-anywhere/?tab=readme-ov-file
https://docs.flutter.dev/cookbook/images/network-image 
https://stackoverflow.com/questions/76547630/exception-caught-by-image-resource-service-object-progressevent
https://docs.flutter.dev/cookbook/images/network-image
https://fluttergems.dev/packages/weather_icons/
https://api.flutter.dev/flutter/material/Icons-class.html
https://stackoverflow.com/questions/51508257/how-to-change-the-appbar-back-button-color


### CSE 340

Finally: thinking about CSE 340 as a whole:

What do you feel was the most valuable thing you learned in CSE 340 that will help you beyond this class, and why?
If you could go back and give yourself 2-3 pieces of advice at the beginning of the class, what would you say and why? (Alternatively: what 2-3 pieces of advice would you give to future students who take CSE 340 and why?)

Answer:

For Patricia:
I think the most valuable thing I learned in CSE 340 was learning Flutter and querying APIs. From the start of the course, I had always wanted to learn frontend coding, so CSE 340 really caught my eye. As the course progresses, I learn more and more topics of not just frontend code, but also topics like querying, secure storage, accessing sensors, etc. These topics will no doubt become important to know for any job that I decide to go into. 

Some advice I would give would be:
1. Watch some videos about Flutter before the course starts. It would be really beneficial for the next assignments since Dart 101 and Calculator are very big jumps in difficulty level.
2. Try to finish the assignment by the original deadline, otherwise you will be behind on the assignments and depend too much on the resubmissions. 

For Leonardo: 
The most valuable thing I learned in CSE 340 was the API/Query experience & the improved logic 
For the API, I learned a massive amount on how to query data from a given API and URL, which seems very applicable to real life (especially using
google api). 
For the logic, I learned a lot better how to use functions such as List.sort, switch expressions, List.every, etc which will be helpful in general not
only in interviews but also reducing the need for for loops.

2 Pieces of advice I would give to future students is 
1. Make sure to understand how to flutter run a project before the 2nd homework is released. This was a large source of anxiety for me and could have 
turned out badly if I wasn't lucky.
2. Think of the resubmission window as a last, last resort since one can fall behind very easily in this class if not.
