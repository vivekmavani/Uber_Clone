
import 'package:uber_driver_app/core/usecases/trip_history/usecase.dart';
import 'package:uber_driver_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_driver_app/domain/repositories/trip_history/trip_history_repository.dart';

class TripHistoryUseCase extends UseCase<List<TripDriver>, NoParams>{
  final TripHistoryRepository repository;

  TripHistoryUseCase({required this.repository});

  @override
  Stream<List<TripDriver>> call(NoParams params) {
    return repository.tripDriverStream();
  }

}