import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:uber_driver_app/presentation/cubit/driver_location/driver_location_cubit.dart';
import 'package:uber_driver_app/presentation/cubit/internet/internet_cubit.dart';
import 'package:uber_driver_app/presentation/cubit/trip_history/trip_history_cubit.dart';
import 'package:uber_driver_app/presentation/cubit/user_req/user_req_cubit.dart';

import 'data/data_sources/common/firebase_data_source.dart';
import 'data/repositories/driver_location/driver_location_repository_impl.dart';
import 'data/repositories/trip_history/trip_history_repository_impl.dart';
import 'domain/repositories/driver_location/driver_location_repository.dart';
import 'domain/repositories/trip_history/trip_history_repository.dart';
import 'domain/use_cases/driver_location/driver_location_usecase.dart';
import 'domain/use_cases/trip_history/driver_update_usecase.dart';
import 'domain/use_cases/trip_history/trip_history_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Cubit

  sl.registerFactory(
        () => TripHistoryCubit(
          tripHistoryUseCase: sl(),
    ),
  );
  sl.registerFactory(
        () => UserReqCubit(
      tripHistoryUseCase: sl(), driverUpdateUseCase:  sl(),
    ),
  );

  sl.registerFactory(
        () => InternetCubit(connectivity: sl()
    ),
  );

  sl.registerFactory(
        () => DriverLocationCubit(driverLocationUseCase: sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => TripHistoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => DriverUpdateUseCase(repository: sl()));
  sl.registerLazySingleton(() => DriverLocationUseCase(repository: sl()));
// Repository
  sl.registerLazySingleton<TripHistoryRepository>(
        () => TripHistoryRepositoryImpl(firebaseNearByMeDataSource: sl()
    ),
  );
  sl.registerLazySingleton<DriverLocationRepository>(
        () => DriverLocationRepositoryImpl(firebaseNearByMeDataSource: sl()
    ),
  );
  // Data sources
  sl.registerLazySingleton<FirebaseDataSource>(
        () => FirebaseDataSource(),
  );
  sl.registerLazySingleton<Connectivity>(
        () => Connectivity(),
  );

}
