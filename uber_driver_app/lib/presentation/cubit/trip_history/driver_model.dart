import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_driver_app/domain/entities/trip_history/driver_entity.dart';

class DriverModel extends DriverEntity {
  DriverModel(
      {
      required this.is_online,
      required this.driver_id,})
      : super(
            is_online: is_online,driver_id: driver_id
  );

  factory DriverModel.fromJson(Map<dynamic, dynamic> value) {
    return DriverModel(
      is_online: value['is_online'], driver_id: value['driver_id'],
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'is_online': is_online,
      'driver_id': driver_id
    };
  }


  final bool? is_online;
  final String? driver_id;
}
