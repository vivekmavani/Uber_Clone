
import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_driver_app/data/models/driver_location/driver_model.dart';
import 'package:uber_driver_app/presentation/cubit/driver_location/driver_location_cubit.dart';
class DriverLocationController extends GetxController  {
  late Position currentPosition;

  changePosition(Position position, GoogleMapController controller, BuildContext context){
    currentPosition = position;
   //BlocProvider.of<DriverLocationCubit>(context).updateDriver(isOnline);
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