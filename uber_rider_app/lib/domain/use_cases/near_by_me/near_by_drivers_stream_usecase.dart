import 'package:dartz/dartz.dart';
import 'package:uber_rider_app/core/error/near_by_me/failures.dart';
import 'package:uber_rider_app/core/usecases/near_by_me/usecase.dart';
import 'package:uber_rider_app/data/models/near_by_me/driver_model.dart' as model;
import 'package:uber_rider_app/data/models/near_by_me/driver_model.dart';
import 'package:uber_rider_app/domain/repositories/near_by_me/near_by_me_repository.dart';

class NearByDriversStreamUseCase extends UseCase<List<DriverModel>, NoParams>{
  final NearByMeRepository repository;

  NearByDriversStreamUseCase({required this.repository});
  @override
  Stream<List<DriverModel>> call(NoParams params) {
    return repository.nearByDriversStream();
  }
}