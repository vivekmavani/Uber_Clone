import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uber_rider_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_rider_app/domain/entities/trip_history/trip_history_entity.dart';
import 'dart:ui' as ui;
import 'custom_button.dart';

class TripHistoryTile extends StatelessWidget {
  final TripDriver tripHistoryEntity;
   TripHistoryTile({required this.tripHistoryEntity, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200.0,
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            debugPrint('Received click');
                          },
                          child: tripHistoryEntity.tripHistoryModel.isCompleted == true ?   const Text('COMPLETED') :  const Text('ONGOING'),
                          style: ButtonStyle(
                            backgroundColor:tripHistoryEntity.tripHistoryModel.isCompleted! ?  MaterialStateProperty.all(Colors.green) :
                            MaterialStateProperty.all(Colors.orange),
                          ),
                        ),
                        Text(DateFormat('dd-MM-yy – hh:mm').format(tripHistoryEntity.tripHistoryModel.tripDate!)),
                      ],
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(tripHistoryEntity.tripHistoryModel.source.toString(),style: Theme.of(context).textTheme.headline6,),
                  leading: const Icon(Icons.my_location),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(tripHistoryEntity.tripHistoryModel.destination.toString(),style: Theme.of(context).textTheme.headline6,),
                  leading: const Icon(Icons.location_on_sharp),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _iconWithTitle(tripHistoryEntity.tripHistoryModel.travellingTime.toString(),Icons.watch_later_outlined),
                    tripHistoryEntity.driverModel != null ?
                    _iconWithTitle(tripHistoryEntity.driverModel.name,Icons.bike_scooter) :
                    _iconWithTitle("",Icons.bike_scooter),
                    _iconWithTitle("${tripHistoryEntity.tripHistoryModel.tripAmount}\u{20B9}",Icons.credit_card_rounded),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }

  Widget _iconWithTitle(String data, IconData iconData) {
    return Row(
      children: [
        Icon(iconData),
        Text(data),
      ],
    );
  }
}

class SpecificationWidget extends StatelessWidget {
  final String helpText;
  final String text;

  SpecificationWidget({required this.text, required this.helpText});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              helpText,
              style: TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

}