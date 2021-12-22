
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uber_rider_app/data/models/near_by_me/driver_model.dart';

class TripHistoryEntity extends Equatable{
  final String? source;
  final String? destination;
  final GeoPoint? sourceLocation;
  final GeoPoint? destinationLocation;
  final double? distance;
  final DocumentReference? driverId;
  final DocumentReference? riderId;
  final String? travellingTime;
  final DateTime? tripDate;
  final String? tripId;
  final bool? isCompleted;
  final bool? visiblityToDriver;
  final String? tripAmount;
  final double? rating;
  final DriverModel? driverModel;

   TripHistoryEntity(
      {this.source,
      this.destination,
      this.sourceLocation,
      this.destinationLocation,
      this.distance,
      this.driverId,
      this.riderId,
      this.travellingTime,
      this.tripDate,
      this.tripId,
      this.isCompleted,
      this.visiblityToDriver,
      this.tripAmount,
      this.rating,
      this.driverModel});

  @override
  List<Object?> get props => [
    source, destination, sourceLocation, destinationLocation, distance,
    driverId, riderId, travellingTime, tripDate, tripId,
    isCompleted, visiblityToDriver, tripAmount,rating,driverModel
  ];
}