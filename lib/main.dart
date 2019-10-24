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
          child: ListView(
            children: <Widget>[
              Text("Lorem Ipsum jest tekstem stosowanym jako przykładowy wypełniacz w przemyśle poligraficznym. Został po raz pierwszy użyty w XV w. przez nieznanego drukarza do wypełnienia tekstem próbnej książki. Pięć wieków później zaczął być używany przemyśle elektronicznym, pozostając praktycznie niezmienionym. Spopularyzował się w latach 60. XX w. wraz z publikacją arkuszy Letrasetu, zawierających fragmenty Lorem Ipsum, a ostatnio z zawierającym różne wersje Lorem Ipsum oprogramowaniem przeznaczonym do realizacji druków na komputerach osobistych, jak Aldus PageMaker 1"),
              Text("Element 2óżnych „kombinacji” zdań, słów i akapitów, w przeciwieństwie do zwykłego: „tekst, tekst, tekst”, sprawiającego, że wygląda to „zbyt czytelnie” po polsku. Wielu webmasterów i designerów używa Lorem Ipsum jako domyślnego modelu tekstu i wpisanie w internetowej wyszukiwarce ‘lorem ipsum’ spowoduje znalezienie bardzo wielu stron, które wciąż są w budowie. Wiele wersji tekstu ewoluowało i zmieniało się przez lata, czasem przez przypadek, czasem specjalnie (humorystyc"),
              Text("Element óżnych „kombinacji” zdań, słów i akapitów, w przeciwieństwie do zwykłego: „tekst, tekst, tekst”, sprawiającego, że wygląda to „zbyt czytelnie” po polsku. Wielu webmasterów i designerów używa Lorem Ipsum jako domyślnego modelu tekstu i wpisanie w internetowej wyszukiwarce ‘lorem ipsum’ spowoduje znalezienie bardzo wielu stron, które wciąż są w budowie. Wiele wersji tekstu ewoluowało i zmieniało się przez lata, czasem przez przypadek, czasem specjalnie (humorystyc2"),
              Text("Element 2"),
              Text("Eleóżnych „kombinacji” zdań, słów i akapitów, w przeciwieństwie do zwykłego: „tekst, tekst, tekst”, sprawiającego, że wygląda to „zbyt czytelnie” po polsku. Wielu webmasterów i designerów używa Lorem Ipsum jako domyślnego modelu tekstu i wpisanie w internetowej wyszukiwarce ‘lorem ipsum’ spowoduje znalezienie bardzo wielu stron, które wciąż są w budowie. Wiele wersji tekstu ewoluowało i zmieniało się przez lata, czasem przez przypadek, czasem specjalnie (humorystycment 2"),
              Text("Element 2"),
              Text("Elóżnych „kombinacji” zdań, słów i akapitów, w przeciwieństwie do zwykłego: „tekst, tekst, tekst”, sprawiającego, że wygląda to „zbyt czytelnie” po polsku. Wielu webmasterów i designerów używa Lorem Ipsum jako domyślnego modelu tekstu i wpisanie w internetowej wyszukiwarce ‘lorem ipsum’ spowoduje znalezienie bardzo wielu stron, które wciąż są w budowie. Wiele wersji tekstu ewoluowało i zmieniało się przez lata, czasem przez przypadek, czasem specjalnie (humorystycement 2")
            ],
          ),),
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


//graph
class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(0, 'Warszawa'),
      Company(1, 'Gdańsk'),
      Company(2, 'Kraków'),
      Company(3, 'Szczecin'),
      Company(4, 'Poznań'),

    ];
  }
}

class NewGraph extends StatefulWidget {
  @override
  _NewGraph createState() {
    return new _NewGraph();
  }
}
class _NewGraph extends State<NewGraph> {

  int i=0;
  final List<List<Smog>> data =
  [
    //'Warszawa'
    [ new Smog('CO', 1000.0,10000.0),
      new Smog('O\u2083', 240.0, 120.0),
      new Smog('PM\u2081\u2080', 16.6,50.0),
      new Smog('PM\u2082\u0656\u2085  ', 27,25.0),
      new Smog('SO\u2082', 10.4,350),
      new Smog('NO\u2082', 19.8, 200),
    ],
    //'Gdańsk'
    [ new Smog('CO', 10001.0,10000.0),
      new Smog('O\u2083', 120.0, 120.0),
      new Smog('PM\u2081\u2080', 50.0,50.0),
      new Smog('PM\u2082\u0656\u2085  ', 20,25.0),
      new Smog('SO\u2082', 10.4,350),
      new Smog('NO\u2082', 19.8, 200),
    ],
    //'Kraków'
    [ new Smog('CO', 11001.0,10000.0),
      new Smog('O\u2083', 1205.0, 120.0),
      new Smog('PM\u2081\u2080', 555.0,50.0),
      new Smog('PM\u2082\u0656\u2085  ', 201,25.0),
      new Smog('SO\u2082', 101.4,350),
      new Smog('NO\u2082', 191.8, 200),
    ],
    //'Szczecin'
    [ new Smog('CO', 1000.0,10000.0),
      new Smog('O\u2083', 110.0, 120.0),
      new Smog('PM\u2081\u2080', 40.0,50.0),
      new Smog('PM\u2082\u0656\u2085  ', 10,25.0),
      new Smog('SO\u2082', 11.4,350),
      new Smog('NO\u2082', 13.8, 200),
    ],
    //'Poznań'
    [ new Smog('CO', 1.0,10000.0),
      new Smog('O\u2083', 1.0, 120.0),
      new Smog('PM\u2081\u2080', 1.0,50.0),
      new Smog('PM\u2082\u0656\u2085  ', 1,25.0),
      new Smog('SO\u2082', 1.4,350),
      new Smog('NO\u2082', 1.8, 200),
    ],
  ];

  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
      i=selectedCompany.id;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Wykres")),
      body: Center(
          child:Container(
            padding: EdgeInsets.all(10),
            child: Column(
                children: <Widget>[
                  DropdownButton(
                    value: _selectedCompany,
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdownItem,
                  ),

                  Text(" "),
                  Text("Zanieczyszczenie powietrza względem normy", style: Theme.of(context).textTheme.body2,),
                  HorizontalBarChart(data[i]),
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
//end graph
//map
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
//end map
//W klasie NewPage4 w przyszłości wprowadzamy ziemię 3d z zmianami klimatycznymi
class NewPage4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Lokalizacji"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
           Text("Testowanie lokalizacji. (W przyszłości ziemia 3d pokazująca zmiany klimatyczne na ziemi)"),
          Text('Location: Lat${userLocation?.latitude}, Long: ${userLocation?.longitude}',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
            ],
        ),),
    );
  }
}
