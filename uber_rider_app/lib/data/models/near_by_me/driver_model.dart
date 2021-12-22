import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_rider_app/domain/entities/near_by_me/driver_entity.dart';

class DriverModel extends DriverEntity {
  DriverModel(
      {required this.name,
      required this.vehicle,
      required this.currentLocation,
      required this.is_online,
      required this.driver_id,
      required this.overall_rating})
      : super(
            name: name,
            vehicle: vehicle,
            currentLocation: currentLocation,
            is_online: is_online,driver_id: driver_id
  );

  factory DriverModel.fromJson(Map<dynamic, dynamic> value) {
    return DriverModel(
      name: value['name'],
      vehicle: value['vehicle'],
      currentLocation: value['current_location'],
      is_online: value['is_online'], driver_id: value['driver_id'],
      overall_rating: value['overall_rating'],
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'vehicle': vehicle,
      'current_location': currentLocation,
      'is_online': is_online,
      'driver_id': driver_id,
      'overall_rating' :overall_rating
    };
  }

  final String? name;
  final bool? is_online;
  final DocumentReference? vehicle;
  final GeoPoint? currentLocation;
  final String? driver_id;
  final String? overall_rating;
}
