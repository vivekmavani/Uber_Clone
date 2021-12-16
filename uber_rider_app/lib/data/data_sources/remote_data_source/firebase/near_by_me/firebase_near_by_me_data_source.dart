import 'package:cloud_firestore/cloud_firestore.dart';

 class FirebaseNearByMeDataSource {

   Stream<List<T>> collectionStream<T>({
     required String path,
     required T Function(Map<String, dynamic> data) builder,
     Query Function(Query query)? queryBuilder
   }) {
     Query query = FirebaseFirestore.instance.collection(path).where('is_online', isEqualTo:true);
     if (queryBuilder != null) {
       query = queryBuilder(query);
     }
     final snapshots = query.snapshots();

     return snapshots.map((snapshot) {
       final result =
       snapshot.docs
           .map((snapshot) => builder(snapshot.data() as Map<String, dynamic>))
           .where((value) => value != null)
           .toList();

       return result;
     });
   }
}