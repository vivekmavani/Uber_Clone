
import 'package:uber_rider_app/data/data_sources/remote_data_source/firebase/firebase_data_source.dart';
import 'package:uber_rider_app/data/models/near_by_me/driver_model.dart';
import 'package:uber_rider_app/domain/repositories/near_by_me/near_by_me_repository.dart';

class NearByMeRepositoryImpl implements NearByMeRepository{
 final FirebaseDataSource firebaseNearByMeDataSource;
  NearByMeRepositoryImpl({required this.firebaseNearByMeDataSource});

  @override
  Stream<List<DriverModel>> nearByDriversStream() {
    return  firebaseNearByMeDataSource.collectionStream(
      path: 'drivers',
      builder: (data) => DriverModel.fromJson(data)
     // queryBuilder: (query) => query.where('is_online', isEqualTo:true)
    );
  }
}