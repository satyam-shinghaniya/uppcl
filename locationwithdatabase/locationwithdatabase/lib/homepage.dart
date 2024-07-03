import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';

import 'database/databasehlper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  String locationMessage = "Press the button get location";
  List<Map<String, dynamic>> _locations = [];
  var time;
  String location = '';


  void _getCurrentLocation()async{
    bool serviceEnabled;
    LocationPermission permission;
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location Service are denied');
      
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permission are denied');
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');

    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      locationMessage = "Latitude: ${position.longitude},Longitude: ${position.longitude}";
    });


    DataBaseHelper dataBaseHelper = DataBaseHelper();
    await dataBaseHelper.insertLocation(position.latitude, position.longitude);
    _loadLocatioms();


  }
  void _loadLocatioms() async{
    DataBaseHelper dataBaseHelper = DataBaseHelper();
    List<Map<String, dynamic>> locations = await dataBaseHelper.getLocation();
    setState(() {
      _locations = locations;
      print("data++++++++++++++++++++++");
      print(_locations);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterBackgroundService().on('update').listen((event) {
      setState(() {
        location = event![locationMessage];
        print("location+++++++++++++++++++++++");
        print(location);
      });
    });
    _loadLocatioms();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Services Example'),

      ),
      body: Center(
        child: Column(
          children: [
            Text("services is running..."),
            
            Text(locationMessage),
            ElevatedButton(
                onPressed: _getCurrentLocation,
                child: Text('Get Location')),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _locations.length,
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text('Latitude: ${_locations[index]['latitude']}, Longitude: ${_locations[index]['longitude']}'),

                  );
                }

              ),
            )
          ],
        ),

      ),
    );
  }
}
