import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uber_driver_app/data/models/driver_location/driver_model.dart';
import 'package:uber_driver_app/domain/use_cases/driver_location/driver_location_usecase.dart';

part 'driver_location_state.dart';

class DriverLocationCubit extends Cubit<DriverLocationState> {
  final DriverLocationUseCase driverLocationUseCase;
  DriverLocationCubit({required this.driverLocationUseCase}) : super(DriverLocationInitial());


  getDriverLocation(){
      try {
        emit(DriverLocationLoading());
        final Stream<DriverModel> driverStream =
        driverLocationUseCase.repository.tripDriverStream("6AAsESfgvWdN7g4YE8D3");
        driverStream.listen((event) {
          emit(DriverLocationLoaded(driverModel: event));
        });
      } catch (e) {
        print(e);
        emit(DriverLocationFailureState(e.toString()));
      }
  }

  updateDriver(bool isOnline,DriverModel driverModel) async {
    try{
      await driverLocationUseCase.repository.updateDriver(DriverModel(is_online: isOnline, driver_id: "6AAsESfgvWdN7g4YE8D3",currentLocation: driverModel.currentLocation,profile_img: driverModel.profile_img));
    }catch(e){
      print(e);
    }
  }
  updateDriverSec(GeoPoint geoPoint,DriverModel driverModel, bool is_online) async {
    try{
      await driverLocationUseCase.repository.updateDriver(DriverModel(is_online: is_online,currentLocation: geoPoint, driver_id: driverModel.driver_id,profile_img: driverModel.profile_img));
    }catch(e){
      print(e);
    }
  }
}
