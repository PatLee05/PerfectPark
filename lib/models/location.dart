import 'package:hive/hive.dart';

part 'location.g.dart';

// A class representing a single journal entry
@HiveType(typeId: 1) // Between TypeAdapter id between 0 and 223
class Location {
  @HiveField(0)
  String latitude;

  @HiveField(1)
  String longitude;

  // ORIGINAL CONSTRUCTOR IS VERY IMPORTANT!
  Location(this.latitude, this.longitude);
}