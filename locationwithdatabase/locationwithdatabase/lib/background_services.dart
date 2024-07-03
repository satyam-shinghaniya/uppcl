
import 'dart:io';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:location/location.dart';
import 'package:locationwithdatabase/database/databasehlper.dart';


void startBackgroundServices(){
 //FlutterBackgroundService(onStart);
  //initializeService();
}

void initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      autoStart: true,
      //onBackground: onIosBackground,
    ),
  );
}
void onStart(ServiceInstance service) async{
  if(service is AndroidServiceInstance){
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  Location location = Location();
  DataBaseHelper dbHelper = DataBaseHelper();

  bool serviceEnabled = await location.serviceEnabled();
  if(!serviceEnabled){
    serviceEnabled = await location.requestService();
    if(!serviceEnabled){
      return;
    }
  }

  PermissionStatus permissionStatus = await location.hasPermission();
  if(permissionStatus == PermissionStatus.denied){
    permissionStatus = await location.requestPermission();
    if(permissionStatus != PermissionStatus.granted){
      return;
    }
  }

  location.onLocationChanged.listen((LocationData currentLocation) async {
    double latitude = currentLocation.latitude!;
    double longitude = currentLocation.longitude!;
    String timestamp = ""; //DateTime('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await dbHelper.insertLocation(latitude, longitude);
  });
}