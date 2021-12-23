import 'package:get_it/get_it.dart';
import 'package:uber_driver_app/presentation/cubit/trip_history/trip_history_cubit.dart';

import 'data/data_sources/trip_history/firebase_data_source.dart';
import 'data/repositories/trip_history/trip_history_repository_impl.dart';
import 'domain/repositories/trip_history/trip_history_repository.dart';
import 'domain/use_cases/trip_history/trip_history_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Cubit

  sl.registerFactory(
        () => TripHistoryCubit(
          tripHistoryUseCase: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => TripHistoryUseCase(repository: sl()));
// Repository
  sl.registerLazySingleton<TripHistoryRepository>(
        () => TripHistoryRepositoryImpl(firebaseNearByMeDataSource: sl()
    ),
  );

  // Data sources
  sl.registerLazySingleton<FirebaseDataSource>(
        () => FirebaseDataSource(),
  );

}
