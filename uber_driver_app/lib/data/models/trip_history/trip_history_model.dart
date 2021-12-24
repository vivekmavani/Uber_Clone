import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/geo_point.dart';
import 'package:intl/intl.dart';
import 'package:uber_driver_app/domain/entities/trip_history/trip_history_entity.dart';

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
  final bool? readyForTrip;
  final bool? isArrived;
  final String? tripAmount;
  final double? rating;
  final DocumentReference? riderId;

  factory TripHistoryModel.fromJson(Map<dynamic, dynamic> value, String id) {
    return TripHistoryModel(
        source: value['source'],
        destination: value['destination'],
        sourceLocation: value['source_location'],
        destinationLocation: value['destination_location'],
        distance: value['distance'],
        travellingTime: value['travelling_time'],
        isCompleted: value['is_completed'],
        isArrived: value['is_arrived'],
        readyForTrip: value['ready_for_trip'],
        tripDate: DateTime.parse(value['trip_date']).toString(),
        tripId: id,
        tripAmount: value['trip_amount'].toString(),
        rating: double.parse(value['rating'].toString()),
        riderId: value['rider_id']);
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
      'rider_id': riderId,
      'is_arrived': isArrived,
      'ready_for_trip': readyForTrip,
    };
  }

  TripHistoryModel({
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
    required this.riderId,
    required this.readyForTrip,
    required this.isArrived,
  }) : super(
            source: source,
            destination: destination,
            sourceLocation: sourceLocation,
            destinationLocation: destinationLocation,
            distance: distance,
            travellingTime: travellingTime,
            isCompleted: isCompleted,
            tripDate: tripDate,
            tripId: tripId,
            rating: rating,
            tripAmount: tripAmount,
            riderId: riderId,
            readyForTrip: readyForTrip,
            isArrived: isArrived);
}
