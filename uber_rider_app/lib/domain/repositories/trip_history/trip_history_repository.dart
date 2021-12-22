

import 'package:uber_rider_app/domain/entities/trip_history/trip_driver.dart';

abstract class TripHistoryRepository{
  Stream<List<TripDriver>> tripDriverStream();
}