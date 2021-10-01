import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255,9,167,109),
        accentColor: Colors.green,
        //bottomAppBarColor: Colors.green,
        //fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: MapPage(),
      //initialRoute: SplashScreen.id,
      // routes: {
      //   //'/': (context) => SplashScreen(),
      //   WelcomeScreen.id: (context) => WelcomeScreen(),
      //   LoginScreen.id: (context) => LoginScreen(),
      //   RegistrationScreen.id: (context) => RegistrationScreen(),
      //   '/launch': (context) => LunchingScreen(),
      // },
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  double latitude;
  double longitude;

  // Future<void> getLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   double latitude = position.latitude;
  //   double longitude = position.longitude;
  //   return position;
  // }

  Future<void> getLocation() async {
    try {
      //print("Inside try block.");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true);
      //print( "trying to print type ${position.runtimeType}");
      latitude = position.latitude;
      longitude = position.longitude;

      setState(() {});

      //return position;

      print('latitude is $latitude longitude is $longitude');
    } catch (e) {
      print("Error is " + e);
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    getLocation();
    print('init');
    super.initState();
  }

  double zoomVal = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Routing"),
      ),
      extendBody: true,
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context, latitude, longitude),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        //margin: EdgeInsets.symmetric(vertical: 80.0),
        height: 150.0,
        child: ListView(
          padding: const EdgeInsets.all(5.0),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  _boxes("assets/place.jpg", 20.376118, 85.5209641, "College"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  _boxes('assets/place.jpg', 20.3773854, 85.5277941, "Temple"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  'assets/place.jpg', 20.3791874, 85.5302703, "Police Station"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String restaurantName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(latitude, longitude);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(110.0)),
                        border: Border.all(
                          color: Colors.green,
                          width: 5.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 100.0,
                          backgroundImage: AssetImage(_image),
                        ),
                      ),
                      // width: 180,
                      // height: 200,
                      // child: ClipRRect(
                      //   borderRadius: new BorderRadius.circular(100.0),
                      //   child: Image(
                      //     fit: BoxFit.fill,
                      //     image: AssetImage(_image),
                      //     //image: NetworkImage(_image),
                      //   ),
                      // ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(restaurantName),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 40,
          child: Text(
            restaurantName,
            style: TextStyle(
                color: Colors.green,
                fontSize: 26.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "4.1",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStarHalf,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
                child: Text(
              "(946)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Banki \u00B7 \u0024\u0024 \u00B7 2.4 km",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Closed \u00B7 Opens 17:00 Thu",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _buildGoogleMap(
      BuildContext context, double latitude, double longitude) {
    //double latitude = 20.3766;
    //double longitude = 85.5290;
    print(latitude);

    if (latitude == null || longitude == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.green,
        ),
      );
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(latitude, longitude), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {collegeMarker, templeMarker, policeMarker},
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker collegeMarker = Marker(
  markerId: MarkerId('college'),
  position: LatLng(20.376118, 85.5209641),
  infoWindow: InfoWindow(title: 'College'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueOrange,
  ),
);
Marker templeMarker = Marker(
  markerId: MarkerId('temple'),
  position: LatLng(20.3773854, 85.5277941),
  infoWindow: InfoWindow(title: 'Temple'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueOrange,
  ),
);
Marker policeMarker = Marker(
  markerId: MarkerId('police'),
  position: LatLng(20.3791874, 85.5302703),
  infoWindow: InfoWindow(title: 'Police'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);
