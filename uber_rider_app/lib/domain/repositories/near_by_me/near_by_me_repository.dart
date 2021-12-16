
import 'package:uber_rider_app/data/models/near_by_me/driver_model.dart';

abstract class NearByMeRepository{
  Stream<List<DriverModel>> nearByDriversStream();
}