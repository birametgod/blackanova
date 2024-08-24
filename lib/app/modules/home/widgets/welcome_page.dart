import 'dart:typed_data';
import 'package:blackanova/app/models/user_model.dart' as userModel;
import 'dart:ui' as ui;

import 'package:blackanova/all_imprts.dart';
import '../../../models/hairdresser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;


import './hairdresser_list.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String mapTheme = '';
  LocationData? currentLocation;
  int _selectedTabIndex = 0;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  // Define a Set to hold the markers for hairdressers
  final Set<Marker> _hairdresserMarkers = {};
  final Completer<GoogleMapController> _controller = Completer();
  final searchController = TextEditingController();
  final List<userModel.User> hairdressers = [
    userModel.User(
      name: 'Oulita Niang',
      profileImageUrl: "assets/images/img.png",
      bio: 'My name is Hama and I am a professional hairdresser with 10 years of experience. I specialize in the late...',
      //rate: 3,
      address: '14 boulevard edouard qndk, villeurbanne',
      latitude: 14.7459, // Example latitude value
      longitude: -17.4721, // Example longitude value
      //minimumPrice: 25
      id: '8IihfI6zhUb78zSCIZO6'
    ),
    userModel.User(
      name: 'Yousra Adechokan',
      profileImageUrl: "assets/images/ethiopian.png",
      bio: 'Description of Hairdresser 2',
      rate: 4,
      address: '79 cours de la liberte, lyon',
      latitude: 14.7434, // Example latitude value
      longitude: -17.4854, // Example longitude value
      //minimumPrice: 25
      id: '1gprLLuG0DquNK5zetYZ'
    ),
    // Add more hairdressers as needed
    userModel.User(
      name: 'Seynabou Trawaré',
      profileImageUrl: "assets/images/ethiopian.png",
      bio: 'Description of Hairdresser 2',
      rate: 4,
      address: '79 cours de la liberte, lyon',
      latitude: 14.7434, // Example latitude value
      longitude: -17.4854, // Example longitude value
      //minimumPrice: 25
      id: 'Fu53ADecnofLWq3KYUbU'
    ),
    userModel.User(
      name: 'Maria Keita',
      profileImageUrl: "assets/images/ethiopian.png",
      bio: 'Description of Hairdresser 2',
      rate: 4,
      address: '79 cours de la liberte, lyon',
      latitude: 14.7434, // Example latitude value
      longitude: -17.4854, // Example longitude value
      //minimumPrice: 25
      id: 'iij1kJfnv5ODntcCZykY'
    ),
    userModel.User(
      name: 'Sonia De Carvalho',
      profileImageUrl: "assets/images/ethiopian.png",
      bio: 'Description of Hairdresser 2',
      rate: 4,
      address: '79 cours de la liberte, lyon',
      latitude: 14.7434, // Example latitude value
      longitude: -17.4854, // Example longitude value
      //minimumPrice: 25
      id: 'tF8ivhR9Ne19dH0OgC9q'
    ),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<Uint8List> _getResizedMarkerIcon(String imagePath) async {
    final ByteData byteData = await rootBundle.load(imagePath);
    final Uint8List markerImageBytes = byteData.buffer.asUint8List();

    // Decode the image
    final img.Image markerImage = img.decodeImage(markerImageBytes)!;

    // Resize the image to your desired dimensions
    const int targetWidth = 150; // Set the desired width
    const int targetHeight = 150; // Set the desired height

    final img.Image resizedImage = img.copyResize(
      markerImage,
      width: targetWidth,
      height: targetHeight,
    );

    // Encode the resized image as PNG
    final List<int> resizedImageBytes = img.encodePng(resizedImage);

    return Uint8List.fromList(resizedImageBytes);
  }


  Future<Uint8List> _getMarkerIconBytes(BuildContext context, String imagePath) async {
    final ByteData byteData = await DefaultAssetBundle.of(context).load(imagePath);
    final List<int> byteList = byteData.buffer.asUint8List();
    return Uint8List.fromList(byteList);
  }

  Future<void> searchAndZoom(String address) async {
    List<geocoding.Location> locations = await geocoding.locationFromAddress(address);
    if (locations.isNotEmpty) {
      final geocoding.Location location = locations[0];
      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newLatLng(LatLng(
        location.latitude,
        location.longitude,
      )));
    }
  }



// Create a method to add hairdresser markers
  void _addHairdresserMarkers(BuildContext context) async {
    for (var hairdresser in hairdressers) {
      final Uint8List markerIconBytes = await _getResizedMarkerIcon(hairdresser.profileImageUrl);

      _hairdresserMarkers.add(
        Marker(
          markerId: MarkerId(hairdresser.name), // Unique ID for the marker
          position: LatLng(hairdresser.latitude, hairdresser.longitude),
          infoWindow: InfoWindow(
            title: hairdresser.name,
            snippet: hairdresser.address,
          ),
          icon: BitmapDescriptor.fromBytes(markerIconBytes),
        ),
      );
    }
  }

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        print(currentLocation);
        setState(() {});
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  void locateToLocation() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 13.5,
          target: LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
          ),
        ),
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    DefaultAssetBundle.of(context)
        .loadString('assets/mapTheme/constatel.json')
        .then((value) {
      mapTheme = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Call the method to add hairdresser markers
    _addHairdresserMarkers(context);


    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E7),
      resizeToAvoidBottomInset: true,
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    controller.setMapStyle(mapTheme);
                    _controller.complete(controller);
                  },
                  myLocationButtonEnabled: false,
                  mapToolbarEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 13.5,
                  ),
                  myLocationEnabled: true,
                  circles: {
                    Circle(
                      circleId: const CircleId("1"),
                      center: LatLng(currentLocation!.latitude!,
                          currentLocation!.longitude!),
                      radius: 420,
                      strokeWidth: 0,
                      fillColor: const Color(0xFF006491).withOpacity(0.2),
                    ),
                  },
                  // Add the hairdresser markers
                  markers: _hairdresserMarkers,
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 100,
                    child: SizedBox(
                      height: 240.0,
                      child: HairdresserList(
                        hairdressers: hairdressers,
                      ),
                    )),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                        color: Color(0xFF0F1012),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        )),
                  ),
                ),
                Positioned(
                  right: 16.0,
                  bottom: 90.0,
                  child: FloatingActionButton(
                      backgroundColor: const Color(0xff19191A).withOpacity(0.9),
                      onPressed: () => locateToLocation(),
                      heroTag: 'location',
                      child: const Icon(Icons.my_location)),
                ),
              ],
            ),
    );
  }
}
