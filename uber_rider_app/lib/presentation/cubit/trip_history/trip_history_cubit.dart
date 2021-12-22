import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uber_rider_app/data/models/near_by_me/driver_model.dart';
import 'package:uber_rider_app/data/models/trip_history/trip_history_model.dart';
import 'package:uber_rider_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_rider_app/domain/use_cases/trip_history/driver_rating_usecase.dart';
import 'package:uber_rider_app/domain/use_cases/trip_history/trip_driver_usecase.dart';

part 'trip_history_state.dart';

class TripHistoryCubit extends Cubit<TripHistoryState> {
  final DriverRatingUseCase driverRatingUseCase;
  final TripDriverStreamUseCase tripDriverStreamUseCase;

  TripHistoryCubit(
      {required this.driverRatingUseCase,
      required this.tripDriverStreamUseCase})
      : super(TripHistoryInitial());

  getTripHistory() {
    try {
      emit(const TripHistoryLoading());
      final Stream<List<TripDriver>> tripHistoryList =
          tripDriverStreamUseCase.repository.tripDriverStream();
      tripHistoryList.listen((event) {
        emit(TripHistoryLoaded(tripHistoryList: event));
      });
    } catch (e) {
      print(e);
      emit(TripHistoryFailureState(e.toString()));
    }
  }

  setRatingForDriver(double rating, TripDriver tripDriver) async {
    try {
      // emit(const NearByMeLoading());
      await driverRatingUseCase.repository.setRating(TripDriver(
          TripHistoryModel(
              destinationLocation: tripDriver.tripHistoryModel.destinationLocation,
              destination: tripDriver.tripHistoryModel.destination,
              tripId: tripDriver.tripHistoryModel.tripId,
              distance: tripDriver.tripHistoryModel.distance,
              source: tripDriver.tripHistoryModel.source,
              isCompleted: tripDriver.tripHistoryModel.isCompleted,
              travellingTime: tripDriver.tripHistoryModel.travellingTime,
              tripDate: tripDriver.tripHistoryModel.tripDate.toString(),
              tripAmount: tripDriver.tripHistoryModel.tripAmount,
              driverId: tripDriver.tripHistoryModel.driverId,
              rating: rating,
              sourceLocation: tripDriver.tripHistoryModel.sourceLocation),
          DriverModel(
              overall_rating:
              double.parse(tripDriver.driverModel.overall_rating!) == 0.0 ?
              '$rating' :
              '${(double.parse(tripDriver.driverModel.overall_rating!) + rating) / 2}',
              driver_id: tripDriver.driverModel.driver_id,
              name: tripDriver.driverModel.name,
              currentLocation: tripDriver.driverModel.currentLocation,
              is_online: tripDriver.driverModel.is_online,
              vehicle: tripDriver.driverModel.vehicle))).whenComplete(() {
        getTripHistory();
      });

    } catch (e) {
      print(e);
    }
  }
}
