import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/widgets/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  final searchController = TextEditingController();
  String mapTheme = '';
  LocationData? currentLocation;
  int _selectedTabIndex = 0;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
    print(currentLocation);
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

  /*
  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyCsssm2muVjmMAZ43uuFdKKjqtNDXG7LEI", // Your Google Map Key
      PointLatLng(_center.latitude, _center.longitude),
      PointLatLng(_centerTwo.latitude, _centerTwo.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }*/

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
    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E7),
      resizeToAvoidBottomInset: false,
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
                  ),
                Positioned(
                  top: 100.0,
                  left: 16.0,
                  right: 16.0,
                  child: Row(
                    children: [
                       Expanded(
                        child: TextFormField(autofocus: false,
                          controller: searchController,
                          style: AppTextStyles.blackanova.poppinsFieldTitle
                              .copyWith(color: Colors.white),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                                   Icons.search,
                                  color: Colors.white,
                                ),
                            contentPadding: const EdgeInsets.all(20),
                            filled: true,
                            fillColor: const Color(0xff19191A).withOpacity(0.9),
                            hintText: "Search Address ...",
                            hintStyle: const TextStyle(
                              color: Colors.white
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color:Color(0xff19191A),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.redAccent,
                                ),
                                borderRadius: BorderRadius.circular(20.0)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 3,
                                  color: Colors.redAccent,
                                ),
                                borderRadius: BorderRadius.circular(20.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                color: const Color(0xff19191A).withOpacity(1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: const Color(0xff19191A).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: IconButton(
                          icon: const Icon(
                              Icons.toc_outlined,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {
                            // Handle search button tap
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon:  Icon(
                              Icons.home_filled,
                            color: _selectedTabIndex == 0 ? const Color(0xFF14CACA) : Colors.white,
                          ),
                          onPressed: () {
                            // Handle Home icon tap
                            setState(() {
                              _selectedTabIndex = 0;
                            });
                          },
                        ),
                        IconButton(
                          icon:  Icon(
                              Icons.calendar_month,
                            color: _selectedTabIndex == 1 ? const Color(0xFF14CACA) : Colors.white,
                          ),
                          onPressed: () {
                            // Handle Search icon tap
                            setState(() {
                              _selectedTabIndex = 1;
                            });
                            FirebaseAuth.instance.signOut();

                          },
                        ),
                        IconButton(
                          icon:  Icon(
                              Icons.perm_identity_sharp,
                            color: _selectedTabIndex == 2 ? const Color(0xFF14CACA) : Colors.white,
                          ),
                          onPressed: () {
                            // Handle Settings icon tap
                            setState(() {
                              _selectedTabIndex = 2;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 16.0,
                  bottom: 90.0,
                  child: FloatingActionButton(
                      backgroundColor: const Color(0xff19191A).withOpacity(0.9),
                      onPressed: () => locateToLocation(),
                      heroTag: 'location',
                      child: Icon(Icons.my_location)
                  ),
                ),
              ],
            ),
    );
  }
}
