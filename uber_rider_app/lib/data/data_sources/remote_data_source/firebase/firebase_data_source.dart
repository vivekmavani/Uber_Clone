import 'package:cloud_firestore/cloud_firestore.dart';

 class FirebaseDataSource {

   Stream<List<T>> collectionStream<T>({
     required String path,
     required T Function(Map<String, dynamic> data) builder,
     Query Function(Query query)? queryBuilder
   }) {
     Query query = FirebaseFirestore.instance.collection(path);
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

   Stream<List<T>> collectionStreamTwo<T>({
     required String path,
     required T Function(Map<String, dynamic> data) builder,
     Query Function(Query query)? queryBuilder,
     int Function(T lhs, T rhs)? sort,
   }) {
     Query query = FirebaseFirestore.instance.collection(path);
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

       if (sort != null) {
         result.sort(sort);
       }
       return result;
     });
   }

   Stream<T>? collectionModel<T>({
     required String path,
     required T Function(Map<String, dynamic> data) builder,
     Query Function(Query query)? queryBuilder,
   }) {
     Query query = FirebaseFirestore.instance.collection(path);
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
       return result.first;
     });
   }
}