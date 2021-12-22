import 'package:uber_rider_app/core/usecases/near_by_me/usecase.dart';
import 'package:uber_rider_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_rider_app/domain/repositories/trip_history/trip_history_repository.dart';

class TripDriverStreamUseCase extends UseCase<List<TripDriver>, NoParams>{
  final TripHistoryRepository repository;

  TripDriverStreamUseCase({required this.repository});

  @override
  Stream<List<TripDriver>> call(NoParams params) {
    return repository.tripDriverStream();
  }
}