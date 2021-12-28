

import 'package:uber_driver_app/core/usecases/trip_history/usecase.dart';
import 'package:uber_driver_app/data/models/driver_location/driver_model.dart';
import 'package:uber_driver_app/domain/repositories/driver_location/driver_location_repository.dart';

class DriverLocationUseCase extends UseCase<DriverModel, Params>{
  final DriverLocationRepository repository;
  DriverLocationUseCase({required this.repository});

  @override
  Stream<DriverModel> call(Params params) {
    return repository.tripDriverStream(params.type as String);
  }

  @override
  Future<void>? call2(Params params) {
    return repository.updateDriver(params.type as DriverModel);
  }

}