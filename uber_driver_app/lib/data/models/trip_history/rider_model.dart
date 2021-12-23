
import 'package:uber_driver_app/domain/entities/trip_history/rider_entity.dart';

class RiderModel extends RiderEntity {
  RiderModel({required this.name, required this.rider_id}) : super(name: name,rider_id:rider_id);

  factory RiderModel.fromJson(Map<dynamic, dynamic> value, String id) {
    return RiderModel(
      name: value['name'],
      rider_id: id,
    );
  }

  final String? name;
  final String? rider_id;
}
