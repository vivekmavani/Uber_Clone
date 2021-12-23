

import 'package:uber_driver_app/domain/entities/trip_history/trip_driver.dart';

abstract class TripHistoryRepository{
  Stream<List<TripDriver>> tripDriverStream();
}