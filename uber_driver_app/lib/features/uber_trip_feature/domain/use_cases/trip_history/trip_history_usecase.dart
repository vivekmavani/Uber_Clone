
import 'package:uber_driver_app/core/usecases/common/usecase.dart';
import 'package:uber_driver_app/features/uber_trip_feature/domain/entities/trip_driver.dart';
import 'package:uber_driver_app/features/uber_trip_feature/domain/repositories/trip_history/trip_history_repository.dart';

class TripHistoryUseCase extends UseCase<List<TripDriver>, Params>{
  final TripHistoryRepository repository;

  TripHistoryUseCase({required this.repository});

  @override
  Stream<List<TripDriver>> call(Params params) {
    return repository.tripDriverStream(params.type as bool,params.type as String, params.type as String);
  }

  @override
  Future<void>? call2(Params params) {
    // TODO: implement call2
    throw UnimplementedError();
  }

}