
import 'package:uber_driver_app/data/models/trip_history/rider_model.dart';
import 'package:uber_driver_app/data/models/trip_history/trip_history_model.dart';

class TripDriver {
final TripHistoryModel tripHistoryModel;
final RiderModel riderModel;

  TripDriver(this.tripHistoryModel, this.riderModel);
}