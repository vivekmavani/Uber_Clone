import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_rider_app/data/models/near_by_me/driver_model.dart'
    as model;
import 'package:uber_rider_app/presentation/controller/near_by_me/near_by_me_controller.dart';
import 'package:uber_rider_app/presentation/cubit/near_by_me/near_by_me_cubit.dart';

class NearByMe extends StatefulWidget {
  const NearByMe({Key? key}) : super(key: key);

  @override
  _NearByMeState createState() => _NearByMeState();
}

class _NearByMeState extends State<NearByMe> {
  late Completer<GoogleMapController> _mapController = Completer();
  late Stream<List<model.DriverModel>> stream;
  late CameraPosition _initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  final startAddressFocusNode = FocusNode();
  final destinationAddressFocusNode = FocusNode();

  //Map markers
  List<Marker> markers = [];
  final c = Get.put(NearByMeController());

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    BlocProvider.of<NearByMeCubit>(context).getNearByDrivers();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<NearByMeCubit, NearByMeState>(
              builder: (context, state) {
                if(state is NearByMeLoading)
                  {
                    return const CircularProgressIndicator();
                  }else if(state is NearByMeLoaded)
                    {
                      stream = state.driverList;
                      return GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: _initialLocation,
                        markers: markers.toSet(),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        mapType: MapType.normal,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: false,
                      );
                    }else if(state is FailureState){
                  return  Container();
                }
                return  Container();
              },
            ),
            // Show zoom buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.blue[100], // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.add),
                          ),
                          onTap: () async {
                            final GoogleMapController controller =
                                await _mapController.future;
                            controller.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Colors.blue.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: const SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.remove),
                          ),
                          onTap: () async {
                            final GoogleMapController controller =
                                await _mapController.future;
                            controller.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child:  ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Colors.white54, // inkwell color
                        child: const SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () async {
                          final GoogleMapController controller =
                          await _mapController.future;
                          c.changePosition(c.currentPosition,controller);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
    stream.listen((List<model.DriverModel> documentList) {
      setState(() {
        markers.clear();
      });
      _updateMarkers(documentList);
    });
  }

  double distance(lat1, lon1, lat2, lon2, unit) {
    var radlat1 = math.pi * lat1 / 180;
    var radlat2 = math.pi * lat2 / 180;
    var theta = lon1 - lon2;
    var radtheta = math.pi * theta / 180;
    var dist = math.sin(radlat1) * math.sin(radlat2) +
        math.cos(radlat1) * math.cos(radlat2) * math.cos(radtheta);
    if (dist > 1) {
      dist = 1;
    }
    dist = math.acos(dist);
    dist = dist * 180 / math.pi;
    dist = dist * 60 * 1.1515;
    if (unit == "K") {
      dist = dist * 1.609344;
    }
    if (unit == "N") {
      dist = dist * 0.8684;
    }
    return dist;
  }

  Future<void> _addMarker(model.DriverModel document) async {
    var _marker = Marker(
      markerId: MarkerId(UniqueKey().toString()),
      position: LatLng(document.currentLocation.latitude, document.currentLocation.longitude),
      infoWindow: InfoWindow(
        title: document.name,
        snippet: document.vehicle.path,
      ),
      icon: document.vehicle.path.split('/').first == "cars"
          ? BitmapDescriptor.fromBytes(
              await getBytesFromAsset('assets/car.png', 100))
          : document.vehicle.path.split('/').first == "bike"
              ? BitmapDescriptor.fromBytes(
                  await getBytesFromAsset('assets/bike.png', 100))
              : BitmapDescriptor.fromBytes(
                  await getBytesFromAsset('assets/rickshaw.png', 100)),
    );
    setState(() {
      markers.add(_marker);
    });
  }

  void _updateMarkers(List<model.DriverModel> documentList) {
    documentList.forEach((model.DriverModel document) {
      if (distance(c.currentPosition.latitude, c.currentPosition.longitude,
              document.currentLocation.latitude, document.currentLocation.longitude, "K") <=
          1) {
        _addMarker(document);
      }
    });
  }


  // Method for retrieving the current location
  void _getCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
        c.changePosition(position,controller);
        print('CURRENT POS: ${c.currentPosition}');
    }).catchError((e) {
      print(e);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
