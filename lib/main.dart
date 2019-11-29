import 'chart.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

//API
//stacje
Future<PostsList> fetchPost() async {
  final response =
  await http.get('http://api.gios.gov.pl/pjp-api/rest/station/findAll');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return PostsList.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }

}
class PostsList {
  final List<Post> posts;
  PostsList({
    this.posts,
  });

  factory PostsList.fromJson(List<dynamic> parsedJson) {

    List<Post> posts = new List<Post>();
    posts = parsedJson.map((i)=>Post.fromJson(i)).toList();

    return new PostsList(
        posts: posts
    );
  }
}
class Post {
  final int id;
  final String stationName;
  final String gegrLat;
  final String gegrLon;
  final City city;
  final String addressStreet;

  Post(
      {this.id,
        this.stationName,
        this.gegrLat,
        this.gegrLon,
        this.city,
        this.addressStreet});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      stationName: json['stationName'],
      gegrLat: json['gegrLat'],
      gegrLon: json['gegrLon'],
      city: json['city'] != null ? new City.fromJson(json['city']) : null,
      addressStreet: json['addressStreet'],
    );
  }

}

class City {
  int id;
  String name;
  Commune commune;

  City({this.id, this.name, this.commune});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    commune =
    json['commune'] != null ? new Commune.fromJson(json['commune']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.commune != null) {
      data['commune'] = this.commune.toJson();
    }
    return data;
  }
}

class Commune {
  String communeName;
  String districtName;
  String provinceName;

  Commune({this.communeName, this.districtName, this.provinceName});

  Commune.fromJson(Map<String, dynamic> json) {
    communeName = json['communeName'];
    districtName = json['districtName'];
    provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['communeName'] = this.communeName;
    data['districtName'] = this.districtName;
    data['provinceName'] = this.provinceName;
    return data;
  }
}
//Api do tego momentu działa można do tych elementów się odwoływać

//index
Future<indexList> getIndex() async {
  final response =
  await http.get('http://api.gios.gov.pl/pjp-api/rest/aqindex/getIndex/52');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return indexList.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
class indexList {
  final List<Index> indexs;
  indexList({
    this.indexs,
  });

  factory indexList.fromJson(List<dynamic> parsedJson) {

    List<Index> indexs = new List<Index>();
    indexs = parsedJson.map((i)=>Index.fromJson(i)).toList();

    return new indexList(
        indexs: indexs
    );
  }
}
class Index {

  final int id;
  final String stCalcDate;
  final StIndexLevel stIndexLevel;
  final String stSourceDataDate;
  final String so2CalcDate;
  final Null so2IndexLevel;
  final String so2SourceDataDate;
  final String no2CalcDate;
  final Null no2IndexLevel;
  final String no2SourceDataDate;
  final String coCalcDate;
  final Null coIndexLevel;
  final String coSourceDataDate;
  final String pm10CalcDate;
  final Null pm10IndexLevel;
  final String pm10SourceDataDate;
  final String pm25CalcDate;
  final Null pm25IndexLevel;
  final Null pm25SourceDataDate;
  final String o3CalcDate;
  final Null o3IndexLevel;
  final String o3SourceDataDate;
  final String c6h6CalcDate;
  final Null c6h6IndexLevel;
  final String c6h6SourceDataDate;

  Index(
      {
        this.id,
        this.stCalcDate,
        this.stIndexLevel,
        this.stSourceDataDate,
        this.so2CalcDate,
        this.so2IndexLevel,
        this.so2SourceDataDate,
        this.no2CalcDate,
        this.no2IndexLevel,
        this.no2SourceDataDate,
        this.coCalcDate,
        this.coIndexLevel,
        this.coSourceDataDate,
        this.pm10CalcDate,
        this.pm10IndexLevel,
        this.pm10SourceDataDate,
        this.pm25CalcDate,
        this.pm25IndexLevel,
        this.pm25SourceDataDate,
        this.o3CalcDate,
        this.o3IndexLevel,
        this.o3SourceDataDate,
        this.c6h6CalcDate,
        this.c6h6IndexLevel,
        this.c6h6SourceDataDate});

  factory Index.fromJson(Map<String, dynamic> json) {
    return Index(
    id: json['id'],
    stCalcDate: json['stCalcDate'],
    stIndexLevel: json['stIndexLevel'] != null
        ? new StIndexLevel.fromJson(json['stIndexLevel'])
        : null,
    stSourceDataDate: json['stSourceDataDate'],
    so2CalcDate: json['so2CalcDate'],
    so2IndexLevel: json['so2IndexLevel'],
    so2SourceDataDate: json['so2SourceDataDate'],
    no2CalcDate: json['no2CalcDate'],
    no2IndexLevel: json['no2IndexLevel'],
    no2SourceDataDate: json['no2SourceDataDate'],
    coCalcDate: json['coCalcDate'],
    coIndexLevel: json['coIndexLevel'],
    coSourceDataDate: json['coSourceDataDate'],
    pm10CalcDate: json['pm10CalcDate'],
    pm10IndexLevel: json['pm10IndexLevel'],
    pm10SourceDataDate: json['pm10SourceDataDate'],
    pm25CalcDate: json['pm25CalcDate'],
    pm25IndexLevel: json['pm25IndexLevel'],
    pm25SourceDataDate: json['pm25SourceDataDate'],
    o3CalcDate: json['o3CalcDate'],
    o3IndexLevel: json['o3IndexLevel'],
    o3SourceDataDate: json['o3SourceDataDate'],
    c6h6CalcDate: json['c6h6CalcDate'],
    c6h6IndexLevel: json['c6h6IndexLevel'],
    c6h6SourceDataDate: json['c6h6SourceDataDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stCalcDate'] = this.stCalcDate;
    if (this.stIndexLevel != null) {
      data['stIndexLevel'] = this.stIndexLevel.toJson();
    }
    data['stSourceDataDate'] = this.stSourceDataDate;
    data['so2CalcDate'] = this.so2CalcDate;
    data['so2IndexLevel'] = this.so2IndexLevel;
    data['so2SourceDataDate'] = this.so2SourceDataDate;
    data['no2CalcDate'] = this.no2CalcDate;
    data['no2IndexLevel'] = this.no2IndexLevel;
    data['no2SourceDataDate'] = this.no2SourceDataDate;
    data['coCalcDate'] = this.coCalcDate;
    data['coIndexLevel'] = this.coIndexLevel;
    data['coSourceDataDate'] = this.coSourceDataDate;
    data['pm10CalcDate'] = this.pm10CalcDate;
    data['pm10IndexLevel'] = this.pm10IndexLevel;
    data['pm10SourceDataDate'] = this.pm10SourceDataDate;
    data['pm25CalcDate'] = this.pm25CalcDate;
    data['pm25IndexLevel'] = this.pm25IndexLevel;
    data['pm25SourceDataDate'] = this.pm25SourceDataDate;
    data['o3CalcDate'] = this.o3CalcDate;
    data['o3IndexLevel'] = this.o3IndexLevel;
    data['o3SourceDataDate'] = this.o3SourceDataDate;
    data['c6h6CalcDate'] = this.c6h6CalcDate;
    data['c6h6IndexLevel'] = this.c6h6IndexLevel;
    data['c6h6SourceDataDate'] = this.c6h6SourceDataDate;
    return data;
  }
}

class StIndexLevel {
  int id;
  String indexLevelName;

  StIndexLevel({this.id, this.indexLevelName});

  StIndexLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    indexLevelName = json['indexLevelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['indexLevelName'] = this.indexLevelName;
    return data;
  }
}

//sensory
Future<sensoryList> getsensory() async {
  final response =
    await http.get('http://api.gios.gov.pl/pjp-api/rest/station/sensors/14');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return sensoryList.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }

}
class sensoryList {
  final List<sensory> sensors;
  sensoryList({
    this.sensors,
  });

  factory sensoryList.fromJson(List<dynamic> parsedJson) {

    List<sensory> sensors = new List<sensory>();
    sensors = parsedJson.map((i)=>sensory.fromJson(i)).toList();

    return new sensoryList(
        sensors: sensors
    );
  }
}

class sensory {
  final int id;
  final int stationId;
  final Param param;

  sensory({this.id, this.stationId, this.param});

  factory sensory.fromJson(Map<String, dynamic> json) {
    return sensory(
    id: json['id'],
    stationId: json['stationId'],
    param: json['param'] != null ? new Param.fromJson(json['param']) : null,
    );}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stationId'] = this.stationId;
    if (this.param != null) {
      data['param'] = this.param.toJson();
    }
    return data;
  }
}

class Param {
  final String paramName;
  final String paramFormula;
  final String paramCode;
  final int idParam;

  Param({this.paramName, this.paramFormula, this.paramCode, this.idParam});

  factory Param.fromJson(Map<String, dynamic> json) {
    return Param(
    paramName: json['paramName'],
    paramFormula: json['paramFormula'],
    paramCode: json['paramCode'],
    idParam: json['idParam'],
    );}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paramName'] = this.paramName;
    data['paramFormula'] = this.paramFormula;
    data['paramCode'] = this.paramCode;
    data['idParam'] = this.idParam;
    return data;
  }
}

//dane
Future<dane> getdane() async {
  var xzc = "http://api.gios.gov.pl/pjp-api/rest/data/getData/88";
  final response =
  await http.get(xzc);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return dane.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }

}

class dane {
 String key;
 List<Values> values;
  var liczba;
  dane({this.key, this.values});

  dane.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    if (json['values'] != null) {
      values = new List<Values>();
      json['values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String date;
  double value;

  Values({this.date, this.value});

  Values.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['value'] = this.value;
    return data;
  }
}
//END API



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
            _Dialog();
          } else {
            _showDialog(); // show dialog
            _Dialog();
          }
        }).catchError((error) {
          _showDialog(); // show dialog
          _Dialog();
        });
      } on SocketException catch (_) {
        _showDialog();
        _Dialog();
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
  void _Dialog() {
    // dialog implementation
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Aplikacja jest wciąż w budowie. Nie wszystkie dane pomiarowe są pobierane. Przepraszamy za utrudnienia."),
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
            return new Earth();
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
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              Text("Czym jest więc zanieczyszczenie powietrza?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(""),
              Text("Smog jest nienaturalnym zjawiskiem atmosferycznym, które polega na współistnieniu związków chemicznych oraz pyłów w naszej atmosferze. Przebywanie, oddychanie nim, zagraża naszemu zdrowiu i życiu. Pochodzenie słowa smog ma swoje korzenie w dwóch anglojęzycznych słowach: smoke – dym oraz fog – mgła."),
              Text(""),
              Text("Rodzaje smogu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(""),
              Text("Jednym z wymienianych rodzajów jest smog londyński. W jego skład wchodzą tlenek siarki (IV), tlenki azotu, tlenki węgla, sadza oraz wspomniane już trudno opadające pyły."),
              Text("Drugim, znanym rodzajem smogu jest smog typu Los Angeles (inaczej tzw. smog fotochemiczny). Występuje on przede wszystkim w miesiącach letnich, w strefach subtropikalnych. W jego skład wchodzą: tlenki węgla, tlenki azotu i węglowodory."),
              Text(""),
              Text("Dopuszczalne normy dla zanieczyszczeń powietrza ustaliły osobno Polska, Unia Europejska a także WHO, czyli Światowa Organizacja Zdrowia.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(""),
              Text("W Polsce normy dla pyłów drobnych PM10 są ustalone na trzech poziomach:"),
              Text(""),
              Text("• poziom dopuszczalny 50 µg/m3 (dobowy)"),
              Text("• poziom informowania 200 µg/m3 (dobowy)"),
              Text("• poziom alarmowy 300 µg/m3 (dobowy)"),
              Text(""),
              Text("Z kolei Unia Europejska dla pyłów drobnych PM10 i PM2,5 ustaliła jedynie poziom dopuszczalny, odpowiednio dla PM10 – 50 µg/m3 (dobowy) i 40 µg/m3 (średni-roczny), a dla pyłu PM2,5 – 25 µg/m3 (średni-roczny)."),
              Text("Normy odnośnie dopuszczalnych stężeń dobowych ustalone przez Światową Organizację Zdrowia, to i 25 μg/m3 dla PM2.5 oraz 50 μg/m3 dla PM10."),
              Text(""),
              Text("Przyczyny zanieczyszczenia powietrza",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(""),
              Text("Smog powstaje na skutek wymieszania powietrza z zanieczyszczeniami i spalinami, powstającymi w efekcie działalności człowieka. Odpowiadają za to fabryki, coraz większa liczba samochodów, palenie węglem, drewnem i innymi paliwami stałymi w piecach. Za jego pojawienie się odpowiada również pogoda, klimat czy ogólne uwarunkowania terenu. O wiele trudniej będzie pozbyć się zanieczyszczeń, gdy jakieś miasto leży w kotlinie, a bezwietrzna pogoda uniemożliwia ich rozprzestrzenienie się i rozrzedzenie, sprawiając że zawisają nad miejscowością."),
              Text(""),
              Text("Niestety, występuje również zjawisko rozprzestrzeniania się zanieczyszczeń na inne obszary, czyli tak zwany smog napływowy. Z pewnością w ten sposób oczyszcza się powietrze w jednym miejscu, jednak staje się ono bardziej zanieczyszczone w drugim. Warto też wiedzieć, że w Polsce mamy do czynienia nie tylko ze smogiem typu londyńskiego, lecz również typu Los Angeles, z uwagi na zanieczyszczenia komunikacyjne."),
              Text(""),
              Text("Skutki zanieczyszczeń powietrza",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(""),
              Text("Skutki zanieczyszczenia powietrza są bardzo łatwo zauważalne – wszyscy widzimy gęsty dym, zalegający nad miastem i każdemu z nas gorzej się takim zanieczyszczonym powietrzem oddycha. Skutki smogu są jednak o wiele bardziej dalekosiężne, niż się niektórym wydaje – ma on bowiem bardzo duży wpływ na nasze zdrowie, prowadząc (przy dłuższej ekspozycji) między innymi do:"),
              Text(""),
              Text("• pojawienia się alergii oraz astmy"),
              Text("• wywołania niewydolności oddechowej"),
              Text("• obniżenia odporności całego organizmu"),
              Text("• wywołania chorób układu krwionośnego i serca"),
              Text("• pojawienia się chorób nowotworowych."),
              Text(""),
              Text("Skutki zanieczyszczenia powietrza odczuwamy również pośrednio, na przykład zjadając skażone nim mięso zwierząt, czy rośliny, które w takich warunkach wzrastały. Agresywne czynniki chemiczne oddziałują bowiem nie tylko na ludzi, lecz także i zwierzęta czy rośliny, a nawet materiały (w tym budowlane). Skutki zanieczyszczeń powietrza czasem się odwlekają, lecz czasem są widoczne natychmiast – najlepiej o tym może świadczyć na przykład znany z historii Wielki smog londyński, który utrzymywał się w 1952 roku ledwie przez 5 dni, ale wywołał 4 tysiące zgonów związanych z komplikacjami oddechowymi po jego wdychaniu. W następnych tygodniach zmarło dalsze 8 tysięcy osób. Skutki smogu były tak katastrofalne, że do dziś rządy zastanawiają się jak jeszcze zmniejszyć jego powstawanie."),

            ],
          ),),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode),
            title: Text("Ciekawostki"),
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
class Stations{
  int id;
  String name;

  Stations(this.id, this.name);
}

class NewGraph extends StatefulWidget {
  @override
  _NewGraph createState() {
    return new _NewGraph();
  }
}
class _NewGraph extends State<NewGraph> {

  int z=0;
  var rng = new Random();
  final List<List<Smog>> data =
  [
    //'Warszawa'
    [
      new Smog('CO', 1111,10000.0),
      new Smog('O\u2083', 44, 120.0),
      new Smog('PM\u2081\u2080', 23,50.0),
      new Smog('PM\u2082\u0656\u2085  ', 22,25.0),
      new Smog('SO\u2082', 32,350),
      new Smog('NO\u2082', 22, 200),
    ],
  ];

  String nameCity2 = "";
  List<Stations> _currencies = [];
  Stations _currentItemSelected ;
  bool y=true;
  onChangeDropdownItem(Stations selected) {
    setState(() {
      print("wybrane:"+selected.name);
      _currentItemSelected = selected;
      z=selected.id;
    });
  }
  List<DropdownMenuItem<Stations>>_dropdownitems=[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Wykres")),
      body: Center(
          child:Container(
            padding: EdgeInsets.all(10),
            child: Column(
                children: <Widget>[
                  FutureBuilder<PostsList>(
                    future: fetchPost(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && y==true) {
                        y=false;
                        var lt= snapshot.data.posts.length;
                        for(var i = 0; i < lt; i++) {
                          _currencies.add(Stations(i, snapshot.data.posts[i].stationName));
                          print(snapshot.data.posts[i].stationName);
                          _dropdownitems.add(
                              DropdownMenuItem(
                                value: _currencies[i],
                                child: Text(_currencies[i].name),
                              )
                          );
                        }
                        _currentItemSelected=_currencies[0];
                        print("_______________________________________________________________________________________");
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // By default, show a loading spinner.
                      return DropdownButton<Stations>(
                        items: _dropdownitems,
                        onChanged:onChangeDropdownItem,
                        value: _currentItemSelected,
                      );
                    },
                  ),
                  FutureBuilder<dane>(
                    future: getdane(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var pm = snapshot.data.values[1].value;
                        if(pm == null){
                          pm = 12;
                        }
                        for(var i = 0; i < 187; i++) {
                          var rng = new Random();
                          data.add(
                            [
                              new Smog('CO', rng.nextInt(12000).toDouble(),10000.0),
                              new Smog('O\u2083', rng.nextInt(140).toDouble(), 120.0),
                              new Smog('PM\u2081\u2080', rng.nextInt(70).toDouble(),50.0),
                              new Smog('PM\u2082\u0656\u2085  ', rng.nextInt(30).toDouble(),25.0),
                              new Smog('SO\u2082', rng.nextInt(400).toDouble(),350),
                              new Smog('NO\u2082', pm, 200),
                            ],
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // By default, show a loading spinner.
                      return Text('');
                    },
                  ),
                  Text(" "),
                  Text("Zanieczyszczenie powietrza względem normy", style: Theme.of(context).textTheme.body2,),
                  HorizontalBarChart(data[z]),
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

  List<Circle> allCircle = [  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa zanieczyszczeń'),
      ),
      body: Center(
        child: FutureBuilder<PostsList>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for(var i = 0; i < snapshot.data.posts.length; i++) {
                allCircle.add(Circle(
                  circleId: CircleId('Warszawa'),
                  center: LatLng(double.parse(snapshot.data.posts[i].gegrLat), double.parse(snapshot.data.posts[i].gegrLon)),
                  strokeColor: Color.fromRGBO(0, 255, 0, 0.5),
                  fillColor: Color.fromRGBO(0, 255, 0, 0.3),
                  radius: 10000,
                ));
              }

              return GoogleMap(circles: Set.from(allCircle),
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
//end map

//W klasie Earth w przyszłości wprowadzamy ziemię 3d z zmianami klimatycznymi

class Earth extends StatefulWidget {
  @override
  _Earth createState() {
    return new _Earth();
  }
}

class _Earth extends State<Earth>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Text("W aktualizacji pokazane będą tutaj zmiany klimatyczne kuli ziemskiej",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),),
    );
  }
}










