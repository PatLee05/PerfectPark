import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:park_locator/models/location.dart';
import 'package:park_locator/provider/location_provider.dart';
import 'package:park_locator/provider/park_list_provider.dart';
import 'package:park_locator/provider/weather_provider.dart';
import 'package:park_locator/views/all_parks.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  // Creates a SECURESTORAGE given package using KEYSTORE on Android and
  // allowing a AES secret key encryption
  const secureStorage = FlutterSecureStorage();
  // Uses the SECURESTORAGE to try to find 'myParkLocatorKey'
  final encryptionKeyString = await secureStorage.read(key: 'myParkLocatorKey');
  if (encryptionKeyString == null) {
    // If null, generate a key and write it to SECURESTORAGE
    // while encoding it using base64url
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'myParkLocatorKey',
      value: base64UrlEncode(key),
    );
  }
  // Use SECURESTORAGE again to find a guaranteed 'myParkLocatorKey'
  final key = await secureStorage.read(key: 'myParkLocatorKey');
  // Decode the key which is in base64url, and use key! since we KNOW the key exists
  final encryptionKeyUint8List = base64Url.decode(key!);
  // print the encryptionKey in the console
  print('Encryption key Uint8List: $encryptionKeyUint8List');

  Hive.registerAdapter(LocationAdapter());
  // Use HIVE to open 'myEncryptedBox' using the ENCRYPTIONKEYUINT8LIST as the AES cipher
  final Box<Location> box = await Hive.openBox<Location>(
    'myEncryptedBox', 
    encryptionCipher: HiveAesCipher(encryptionKeyUint8List), 
  );
  final testLat = (box.isNotEmpty) ? box.get('location')!.latitude : '1.0';
  print('Curr Loc: $testLat');

  runApp(ParkLocator(locationBox: box));
}

class ParkLocator extends StatelessWidget {
  // stores the user's location for Hive
  final Box<Location> locationBox;
  const ParkLocator({required this.locationBox, super.key});

  @override
  Widget build(BuildContext context) {
    // uses MultiProvider since we use 3 providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ParkListProvider>(create: (context) => ParkListProvider(locBox: locationBox)), 
        ChangeNotifierProvider<WeatherProvider>(create: (context) => WeatherProvider()),
        ChangeNotifierProvider<LocationProvider>(create: (context) => LocationProvider()),
      ],
      child: const MaterialApp(
        // So it doesn't cover the weather condition icon
        debugShowCheckedModeBanner: false,
        home: AllParks(),
      ),
    );
  }
}
