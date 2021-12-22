import 'package:get_it/get_it.dart';
import 'package:uber_rider_app/domain/use_cases/trip_history/trip_driver_usecase.dart';
import 'package:uber_rider_app/presentation/cubit/near_by_me/near_by_me_cubit.dart';
import 'package:uber_rider_app/presentation/cubit/trip_history/trip_history_cubit.dart';

import 'data/data_sources/remote_data_source/firebase/firebase_data_source.dart';
import 'data/repositories/near_by_me/near_by_me_repository_impl.dart';
import 'data/repositories/trip_history/trip_history_repository_impl.dart';
import 'domain/repositories/near_by_me/near_by_me_repository.dart';
import 'domain/repositories/trip_history/trip_history_repository.dart';
import 'domain/use_cases/near_by_me/near_by_drivers_stream_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Near By Me
  // Cubit
  sl.registerFactory(
        () => NearByMeCubit(
     nearByDriversStreamUseCase: sl(),
    ),
  );
  sl.registerFactory(
        () => TripHistoryCubit(
         tripDriverStreamUseCase: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => NearByDriversStreamUseCase(repository: sl()));
  sl.registerLazySingleton(() => TripDriverStreamUseCase(repository: sl()));
// Repository
  sl.registerLazySingleton<NearByMeRepository>(
        () => NearByMeRepositoryImpl(firebaseNearByMeDataSource: sl()
    ),
  );

  sl.registerLazySingleton<TripHistoryRepository>(
        () => TripHistoryRepositoryImpl(firebaseNearByMeDataSource: sl()
    ),
  );

  // Data sources
  sl.registerLazySingleton<FirebaseDataSource>(
        () => FirebaseDataSource(),
  );

}
