import 'package:uber_rider_app/core/usecases/near_by_me/usecase.dart';
import 'package:uber_rider_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_rider_app/domain/repositories/trip_history/trip_history_repository.dart';

class DriverRatingUseCase extends UseCase<TripDriver, Params>{
  final TripHistoryRepository repository;

  DriverRatingUseCase({required this.repository});

  @override
 Future<void> call2(Params params) {
    return repository.setRating(params.type as TripDriver);
  }

  @override
  Stream<TripDriver>? call(Params params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}