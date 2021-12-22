import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uber_rider_app/data/models/near_by_me/driver_model.dart';
import 'package:uber_rider_app/domain/use_cases/near_by_me/near_by_drivers_stream_usecase.dart';


part 'near_by_me_state.dart';

class NearByMeCubit extends Cubit<NearByMeState> {
  final NearByDriversStreamUseCase nearByDriversStreamUseCase;

  NearByMeCubit({required this.nearByDriversStreamUseCase}) : super(NearByMeInitial());

  getNearByDrivers(){
    try{
      emit(const NearByMeLoading());
      final Stream<List<DriverModel>> nearByDrivers = nearByDriversStreamUseCase.repository.nearByDriversStream();
      emit(NearByMeLoaded(driverList: nearByDrivers));
    }catch(e){
      print(e);
      emit(FailureState());
    }
  }


}
