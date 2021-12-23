
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uber_driver_app/data/data_sources/trip_history/firebase_data_source.dart';
import 'package:uber_driver_app/data/models/trip_history/rider_model.dart';
import 'package:uber_driver_app/data/models/trip_history/trip_history_model.dart';
import 'package:uber_driver_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_driver_app/domain/repositories/trip_history/trip_history_repository.dart';

class TripHistoryRepositoryImpl implements TripHistoryRepository{
 final FirebaseDataSource firebaseNearByMeDataSource;
  TripHistoryRepositoryImpl({required this.firebaseNearByMeDataSource});
  

  Stream<List<TripHistoryModel>> tripHistoryStream() {
    return firebaseNearByMeDataSource.collectionStream(
        path: 'trips',
        builder: (data,id) =>  TripHistoryModel.fromJson(data,id),
        queryBuilder: (query) => query.
        where('driver_id', isEqualTo: FirebaseFirestore.instance.collection('drivers').doc('6AAsESfgvWdN7g4YE8D3')),
        sort: (lhs, rhs) => DateTime.parse(rhs.tripDate!).compareTo(DateTime.parse(lhs.tripDate!)),
    );
  }


 Stream<List<RiderModel>> riderList() {
   return firebaseNearByMeDataSource.collectionStream(
       path: 'riders',
       builder: (data,id) =>  RiderModel.fromJson(data,id),
   );
 }

 static List<TripDriver> _combiner(
     List<TripHistoryModel> trips, List<RiderModel> riders) {
   return trips.map((trip) {
     final rider = riders.firstWhere(
           (rider) => rider.rider_id == trip.riderId!.id,
     );
     return TripDriver(trip, rider);
   }).toList();
 }

  @override
  Stream<List<TripDriver>> tripDriverStream() {
  return  Rx.combineLatest2(
      tripHistoryStream(),
      riderList(),
      _combiner,
    );
  }

}
