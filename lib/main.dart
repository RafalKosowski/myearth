import 'package:flutter/material.dart';
import 'chart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      builder: (context) => LocationService().locationStream,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: HomePage(),
          )),
    );
  }
}


//gps
class LocationService {
  UserLocation _currentLocation;
  var location = Location();
  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
  }
  StreamController<UserLocation> _locationController =
  StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationController.stream;
  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      if (granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged().listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
      }
    });
  }
}

class UserLocation {
  final double latitude;
  final double longitude;
  UserLocation({this.latitude, this.longitude});
}//gps


class HomePage extends StatefulWidget {
  @override
  _HomePage createState() {
    return new _HomePage();
  }
}

class _HomePage extends State<HomePage> {

  @override
  void initState() {
    super.initState();


    // Check internet connection
    Timer.run(() {
      try {
        InternetAddress.lookup('google.com').then((result) {
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
          } else {
            _showDialog(); // show dialog
          }
        }).catchError((error) {
          _showDialog(); // show dialog
        });
      } on SocketException catch (_) {
        _showDialog();
        print('not connected'); // show dialog
      }
    });
  }
  //End check

  //Dialog check internet
  void _showDialog() {
    // dialog implementation
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Brak połączenia z internetem. Do poprawnego działania aplikacji wymagany jest internet"),
        ));
  }
  // End dialog check internet


  String text = 'Home';

  _onTap(int index) {
    setState(() {
      index = index;
      switch (index) {
        case 0:
          break;
        case 1:
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return  new NewGraph();
          }));
          break;
        case 2:
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new NewMap();
          }));
          break;
        case 3:
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new NewPage4();
          }));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My Earth"),
      ),
      body: Center(
          child: Text("Home",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode),
            title: Text("Blog"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            title: Text("Wykres"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text("Mapa"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.blur_circular),
            title: Text("Ziemia"),
          ),
        ],
        onTap: _onTap,
      ),
    );
  }
}


class NewGraph extends StatelessWidget {
  final List<DropdownMenuItem<int>> listDrop = [];
  void loadData(){
    listDrop.add(DropdownMenuItem(
      child:Text("Warszawa"),
      value: 1,
    ));
    listDrop.add(DropdownMenuItem(
      child:Text("Kraków"),
      value: 2,
    ));
    listDrop.add(DropdownMenuItem(
      child:Text("Gdańsk"),
      value: 3,
    ));
  }

  final List<Smog> data = [
    new Smog('CO', 1000.0,10000.0),
    new Smog('O\u2083', 240.0, 120.0),
    new Smog('PM\u2081\u2080', 16.6,50.0),
    new Smog('PM\u2082\u0656\u2085  ', 27,25.0),
    new Smog('SO\u2082', 10.4,350),
    new Smog('NO\u2082', 19.8, 200),
  ];

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      appBar: AppBar(title: Text("Wykres")),
      body: Center(
          child:Container(
            padding: EdgeInsets.all(10),
            child: Column(
                children: <Widget>[
                  DropdownButton(items: listDrop ,hint: Text("Wybierz miasto"), onChanged:null,),
                  Text(" "),
                  Text("Zanieczyszczenie powietrza względem normy", style: Theme.of(context).textTheme.body2,),
                  HorizontalBarChart(data),
                  Text(" "),
                  Text("Nazwy substancji"),
                  Text('CO - Tlenek węgla (norma: 10000 µg/m\u00B3)'),
                  Text('O\u2083 - Ozon troposferyczny(norma: 120 µg/m\u00B3)'),
                  Text('SO\u2082 - Dwutlenek siarki (norma: 350 µg/m\u00B3)'),
                  Text('NO\u2082 - Dwutlenek azotu (norma: 200 µg/m\u00B3)'),
                  Text('PM\u2081\u2080 - Pył zawieszony PM10 (norma: 50 µg/m\u00B3)'),
                  Text('PM\u2082\u0656\u2085 - Pył zawieszony PM2,5 (norma: 25 µg/m\u00B3)'),
                ]
            ),
          )
        // DropdownButton(items:null,onChanged: null,),
        //HorizontalBarChart(data),
      ),
    );
  }
}

class NewMap extends StatelessWidget {

  GoogleMapController mapController;

  final LatLng _center = const LatLng(52.2297700, 21.0117800);


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<Circle> allCircle = [
    Circle(
      circleId: CircleId('myCircle'),
      center: LatLng(52.2297700, 21.0117800),
      strokeColor:  Color.fromRGBO(255, 0, 0, 0.5),
      fillColor: Color.fromRGBO(255, 0, 0, 0.3),
      radius: 15000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        circles: Set.from(allCircle),
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}

class NewPage4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Współrzędne"),
      ),
      body: Center(
          child: Text('Location: Lat${userLocation?.latitude}, Long: ${userLocation?.longitude}',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))),
    );
  }
}

