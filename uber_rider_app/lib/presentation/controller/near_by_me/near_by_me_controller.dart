
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class NearByMeController extends GetxController  {
  late Position currentPosition;
  //Map markers
 List<Marker> markers = [];

  changePosition(Position position, GoogleMapController controller){
    currentPosition = position;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18.0,
        ),
      ),
    );
  }


}