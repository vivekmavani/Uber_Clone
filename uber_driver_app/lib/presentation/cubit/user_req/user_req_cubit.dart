import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uber_driver_app/data/models/trip_history/rider_model.dart';
import 'package:uber_driver_app/data/models/trip_history/trip_history_model.dart';
import 'package:uber_driver_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_driver_app/domain/use_cases/trip_history/driver_update_usecase.dart';
import 'package:uber_driver_app/domain/use_cases/trip_history/trip_history_usecase.dart';
import 'package:uber_driver_app/data/models/driver_location/driver_model.dart';

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
          if(accept == false)
          {
          final Stream<List<TripDriver>> tripHistoryList =
          tripHistoryUseCase.repository.tripDriverStream(false,accept == false ? null : tripDriverUpdated!.tripHistoryModel.tripId);
          tripHistoryList.listen((event) {
            if(accept == false) {
              emit(UserReqLoaded(tripHistoryList: event));
            }else
              {
                final Stream<List<TripDriver>> tripHistoryList =
                tripHistoryUseCase.repository.tripDriverStream(false,accept == false ? null : tripDriverUpdated!.tripHistoryModel.tripId);
                tripHistoryList.listen((event) {
                  emit(UserReqDisplayOne(tripDriver: event[0]));
                });
              }
          });
              }else
                {
                  final Stream<List<TripDriver>> tripHistoryList =
                  tripHistoryUseCase.repository.tripDriverStream(false,accept == false ? null : tripDriverUpdated!.tripHistoryModel.tripId);
                  tripHistoryList.listen((event) {
                    emit(UserReqDisplayOne(tripDriver: event[0]));
                  });

                }

    } catch (e) {
      print(e);
      emit(UserReqFailureState(e.toString()));
    }
  }

  isAccept(TripDriver tripDriver,bool isDriver, bool isCompleted) async {
    accept = true;
    tripDriverUpdated = tripDriver;
    try {
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
                      isCompleted: tripDriver.tripHistoryModel.isArrived == true && isCompleted == false ? true : tripDriver.tripHistoryModel.isCompleted,
                      travellingTime:
                          tripDriver.tripHistoryModel.travellingTime,
                      tripDate: tripDriver.tripHistoryModel.tripDate.toString(),
                      tripAmount: tripDriver.tripHistoryModel.tripAmount,
                      rating: tripDriver.tripHistoryModel.rating,
                      sourceLocation:
                          tripDriver.tripHistoryModel.sourceLocation,
                      readyForTrip: isDriver == true ? accept : tripDriver.tripHistoryModel.readyForTrip,
                      riderId: tripDriver.tripHistoryModel.riderId,
                      isArrived: isDriver == true ? tripDriver.tripHistoryModel.isArrived : true),
                  RiderModel(
                      rider_id: tripDriver.riderModel.rider_id,
                      name: tripDriver.riderModel.name)),
              DriverModel(
                  is_online: false,
                  driver_id: '6AAsESfgvWdN7g4YE8D3',),isDriver);
    } catch (e) {
      print(e);
      emit(UserReqFailureState(e.toString()));
    }
  }
}
