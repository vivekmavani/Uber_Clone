
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uber_rider_app/data/data_sources/remote_data_source/firebase/firebase_data_source.dart';
import 'package:uber_rider_app/data/models/near_by_me/driver_model.dart';
import 'package:uber_rider_app/data/models/trip_history/trip_history_model.dart';
import 'package:uber_rider_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_rider_app/domain/entities/trip_history/trip_history_entity.dart';
import 'package:uber_rider_app/domain/repositories/trip_history/trip_history_repository.dart';

class TripHistoryRepositoryImpl implements TripHistoryRepository{
 final FirebaseDataSource firebaseNearByMeDataSource;
  TripHistoryRepositoryImpl({required this.firebaseNearByMeDataSource});
  

  Stream<List<TripHistoryModel>> tripHistoryStream() {
    return firebaseNearByMeDataSource.collectionStreamTwo(
        path: 'trips',
        builder: (data) =>  TripHistoryModel.fromJson(data),
        queryBuilder: (query) => query.
        where('rider_id', isEqualTo: FirebaseFirestore.instance.collection('riders').doc('kuldip123456'))
    );
  }


 Stream<List<DriverModel>> driverList() {
   return firebaseNearByMeDataSource.collectionStreamTwo(
       path: 'drivers',
       builder: (data) =>  DriverModel.fromJson(data),
   );
 }

 static List<TripDriver> _combiner(
     List<TripHistoryModel> trips, List<DriverModel> drivers) {
   return trips.map((trip) {
     final driver = drivers.firstWhere(
           (driver) => driver.driver_id == trip.driverId!.id,
     );
     return TripDriver(trip, driver);
   }).toList();
 }

  @override
  Stream<List<TripDriver>> tripDriverStream() {
  return  Rx.combineLatest2(
      tripHistoryStream(),
      driverList(),
      _combiner,
    );
  }
 @override
 Future<void> setRating(TripDriver tripDriver) async {
   firebaseNearByMeDataSource.setData(
     path: 'trips/${tripDriver.tripHistoryModel.tripId}',
     data: tripDriver.tripHistoryModel.toMap(),
   );
   firebaseNearByMeDataSource.setData(
     path: 'drivers/${tripDriver.driverModel.driver_id}',
     data: tripDriver.driverModel.toMap(),
   );
 }
}
