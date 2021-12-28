import 'package:uber_driver_app/data/models/driver_location/driver_model.dart';

abstract class DriverLocationRepository{
  Stream<DriverModel> tripDriverStream(String? driverId);
  Future<void> updateDriver(DriverModel driverModel);
}