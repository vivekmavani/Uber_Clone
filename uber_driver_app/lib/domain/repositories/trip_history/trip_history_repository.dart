


import 'package:uber_driver_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_driver_app/data/models/driver_location/driver_model.dart';

abstract class TripHistoryRepository{
  Stream<List<TripDriver>> tripDriverStream(bool isHistory, String? tripId);
  Future<void> updateDriverAndTrip(TripDriver tripDriver,DriverModel driverModel,bool isDriver);
}