import 'package:uber_driver_app/core/usecases/trip_history/usecase.dart';
import 'package:uber_driver_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_driver_app/domain/repositories/trip_history/trip_history_repository.dart';
import 'package:uber_driver_app/data/models/driver_location/driver_model.dart';

class DriverUpdateUseCase extends UseCase<TripDriver, Params>{
  final TripHistoryRepository repository;
  DriverUpdateUseCase({required this.repository});

  @override
  Stream<TripDriver>? call(Params params) {
    // TODO: implement call
    throw UnimplementedError();
  }

  @override
  Future<void> call2(Params params) {
    return repository.updateDriverAndTrip(params.type as TripDriver,params.type as DriverModel,params.type as bool);
  }
}