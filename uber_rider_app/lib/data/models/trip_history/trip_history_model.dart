import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/geo_point.dart';
import 'package:intl/intl.dart';
import 'package:uber_rider_app/data/models/near_by_me/driver_model.dart';
import 'package:uber_rider_app/domain/entities/trip_history/trip_history_entity.dart';

class TripHistoryModel extends TripHistoryEntity {
  final String? source;
  final String? destination;
  final GeoPoint? sourceLocation;
  final GeoPoint? destinationLocation;
  final double? distance;
  final String? travellingTime;
  final String? tripDate;
  final String? tripId;
  final bool? isCompleted;
  final String? tripAmount;
  final double? rating;
  final DocumentReference? driverId;
  factory TripHistoryModel.fromJson(Map<dynamic, dynamic> value) {
    return TripHistoryModel(
        source : value['source'],
        destination : value['destination'],
        sourceLocation : value['source_location'],
        destinationLocation : value['destination_location'],
        distance : value['distance'],
        travellingTime : value['travelling_time'],
        isCompleted : value['is_completed'],
        tripDate : DateTime.parse(value['trip_date']).toString(),
        tripId : value['trip_id'],
        tripAmount : value['trip_amount'].toString(),
        rating : double.parse(value['rating'].toString()),
        driverId : value['driver_id']
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
   'source': source,
   'destination': destination,
   'source_location': sourceLocation,
   'destination_location': destinationLocation,
   'distance': distance,
   'travelling_time': travellingTime,
   'is_completed': isCompleted,
   'trip_date': tripDate,
   'trip_id': tripId,
   'trip_amount': tripAmount,
   'rating': rating,
   'driver_id': driverId
    };
  }


   TripHistoryModel(
      {
      required this.source,
      required this.destination,
      required this.sourceLocation,
      required this.destinationLocation,
      required this.distance,
      required this.travellingTime,
      required this.isCompleted,
      required this.tripDate,
      required this.tripId,
      required this.tripAmount,
      required this.rating,
      required this.driverId})
      : super(
            source:source,
            destination:destination,
            sourceLocation:sourceLocation,
            destinationLocation:destinationLocation,
            distance:distance,
            travellingTime:travellingTime,
            isCompleted:isCompleted,
            tripDate:tripDate,
            tripId:tripId,
            rating:rating,
            tripAmount: tripAmount,
            driverId: driverId);
}
