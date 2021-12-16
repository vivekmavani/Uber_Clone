part of 'near_by_me_cubit.dart';

abstract class NearByMeState extends Equatable {
  const NearByMeState();
}

class NearByMeInitial extends NearByMeState {
  @override
  List<Object> get props => [];
}

class NearByMeLoading extends NearByMeState{
  const NearByMeLoading();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}



class NearByMeLoaded extends NearByMeState{
  final Stream<List<DriverModel>> driverList;
  const NearByMeLoaded({required this.driverList});

  @override
  // TODO: implement props
  List<Object?> get props => [driverList];
}

class FailureState extends NearByMeState {
  @override
  List<Object> get props => [];
}
