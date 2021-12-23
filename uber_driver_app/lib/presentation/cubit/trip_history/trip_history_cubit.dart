import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uber_driver_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_driver_app/domain/use_cases/trip_history/trip_history_usecase.dart';

part 'trip_history_state.dart';

class TripHistoryCubit extends Cubit<TripHistoryState> {
  final TripHistoryUseCase tripHistoryUseCase;

  TripHistoryCubit(
      {required this.tripHistoryUseCase})
      : super(TripHistoryInitial());

  getTripHistory() {
    try {
      emit(const TripHistoryLoading());
      final Stream<List<TripDriver>> tripHistoryList =
      tripHistoryUseCase.repository.tripDriverStream();
      tripHistoryList.listen((event) {
        emit(TripHistoryLoaded(tripHistoryList: event));
      });
    } catch (e) {
      print(e);
      emit(TripHistoryFailureState(e.toString()));
    }
  }
}
