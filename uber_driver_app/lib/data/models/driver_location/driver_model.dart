import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_driver_app/domain/entities/driver_location/driver_entity.dart';

class DriverModel extends DriverEntity {
  DriverModel({
    required this.is_online,
    required this.driver_id,
    this.profile_img,
    this.currentLocation,
  }) : super(
            is_online: is_online,
            driver_id: driver_id,
            profile_img: profile_img,
            currentLocation: currentLocation);

  factory DriverModel.fromJson(Map<dynamic, dynamic> value) {
    return DriverModel(
      is_online: value['is_online'],
      driver_id: value['driver_id'],
      profile_img: value['profile_img'],
      currentLocation: value['current_location'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'is_online': is_online,
      'driver_id': driver_id,
      'profile_img': profile_img,
      'current_location': currentLocation
    };
  }

  final bool? is_online;
  final String? driver_id;
  final String? profile_img;
  final GeoPoint? currentLocation;
}
