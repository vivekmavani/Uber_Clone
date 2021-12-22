import 'package:uber_rider_app/data/models/near_by_me/driver_model.dart';
import 'package:uber_rider_app/data/models/trip_history/trip_history_model.dart';

class TripDriver {
final TripHistoryModel tripHistoryModel;
final DriverModel driverModel;

  TripDriver(this.tripHistoryModel, this.driverModel);
}