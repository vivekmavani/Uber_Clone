import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uber_driver_app/data/models/trip_history/rider_model.dart';
import 'package:uber_driver_app/data/models/trip_history/trip_history_model.dart';
import 'package:uber_driver_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_driver_app/domain/use_cases/trip_history/driver_update_usecase.dart';
import 'package:uber_driver_app/domain/use_cases/trip_history/trip_history_usecase.dart';
import 'package:uber_driver_app/presentation/cubit/trip_history/driver_model.dart';

part 'user_req_state.dart';

class UserReqCubit extends Cubit<UserReqState> {
  final TripHistoryUseCase tripHistoryUseCase;
  final DriverUpdateUseCase driverUpdateUseCase;
  bool accept = false;
  TripDriver? tripDriverUpdated;

  UserReqCubit(
      {required this.driverUpdateUseCase, required this.tripHistoryUseCase})
      : super(UserReqInitial());

  getUserReq() {
    try {
          emit(UserReqLoading());
          final Stream<List<TripDriver>> tripHistoryList =
          tripHistoryUseCase.repository.tripDriverStream(false);
          tripHistoryList.listen((event) {
            if(accept == false)
              {
                emit(UserReqLoaded(tripHistoryList: event));
              }else
                {
                  emit(UserReqDisplayOne(tripDriver: tripDriverUpdated!));
                }

          });
    } catch (e) {
      print(e);
      emit(UserReqFailureState(e.toString()));
    }
  }

  isAccept(TripDriver tripDriver) async {
    accept = true;
    tripDriverUpdated = tripDriver;
    try {
      // emit(const NearByMeLoading());
      await driverUpdateUseCase.repository
          .updateDriverAndTrip(
              TripDriver(
                  TripHistoryModel(
                      destinationLocation:
                          tripDriver.tripHistoryModel.destinationLocation,
                      destination: tripDriver.tripHistoryModel.destination,
                      tripId: tripDriver.tripHistoryModel.tripId,
                      distance: tripDriver.tripHistoryModel.distance,
                      source: tripDriver.tripHistoryModel.source,
                      isCompleted: tripDriver.tripHistoryModel.isCompleted,
                      travellingTime:
                          tripDriver.tripHistoryModel.travellingTime,
                      tripDate: tripDriver.tripHistoryModel.tripDate.toString(),
                      tripAmount: tripDriver.tripHistoryModel.tripAmount,
                      rating: tripDriver.tripHistoryModel.rating,
                      sourceLocation:
                          tripDriver.tripHistoryModel.sourceLocation,
                      readyForTrip: accept,
                      riderId: tripDriver.tripHistoryModel.riderId,
                      isArrived: tripDriver.tripHistoryModel.isArrived),
                  RiderModel(
                      rider_id: tripDriver.riderModel.rider_id,
                      name: tripDriver.riderModel.name)),
              DriverModel(
                  is_online: false,
                  driver_id: '6AAsESfgvWdN7g4YE8D3',));
    } catch (e) {
      print(e);
      emit(UserReqFailureState(e.toString()));
    }
  }
}
