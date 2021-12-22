import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:uber_rider_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_rider_app/presentation/cubit/trip_history/trip_history_cubit.dart';

class TripHistoryTile extends StatefulWidget {
  final TripDriver tripHistoryEntity;

  TripHistoryTile({required this.tripHistoryEntity, Key? key})
      : super(key: key);

  @override
  State<TripHistoryTile> createState() => _TripHistoryTileState();
}

class _TripHistoryTileState extends State<TripHistoryTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.tripHistoryEntity.tripHistoryModel.isCompleted! &&
              widget.tripHistoryEntity.tripHistoryModel.rating == 0.0
          ? 250.0
          : 200.0,
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
                      child:
                          widget.tripHistoryEntity.tripHistoryModel.isCompleted == true
                              ? const Text('COMPLETED')
                              : const Text('ONGOING'),
                      style: ButtonStyle(
                        backgroundColor:
                            widget.tripHistoryEntity.tripHistoryModel.isCompleted!
                                ? MaterialStateProperty.all(Colors.green)
                                : MaterialStateProperty.all(Colors.orange),
                      ),
                    ),
                    Row(
                      children: [
                        Text( DateFormat('dd-MM-yy').format(DateTime.parse(widget.tripHistoryEntity.tripHistoryModel.tripDate!))
                            ),
                        Visibility(
                          visible:
                              widget.tripHistoryEntity.tripHistoryModel.rating != 0,
                          child: Container(
                              width: 30,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.green[700],
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        widget.tripHistoryEntity
                                            .tripHistoryModel.rating
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    const SizedBox(width: 1),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 10.0,
                                    )
                                  ])),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  widget.tripHistoryEntity.tripHistoryModel.source.toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                leading: const Icon(Icons.my_location),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  widget.tripHistoryEntity.tripHistoryModel.destination.toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                leading: const Icon(Icons.location_on_sharp),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _iconWithTitle(
                      widget.tripHistoryEntity.tripHistoryModel.travellingTime
                          .toString(),
                      Icons.watch_later_outlined),
                  widget.tripHistoryEntity.driverModel != null
                      ? _iconWithTitle(widget.tripHistoryEntity.driverModel.name!,
                          Icons.bike_scooter)
                      : _iconWithTitle("driver", Icons.bike_scooter),
                  _iconWithTitle(
                      "${widget.tripHistoryEntity.tripHistoryModel.tripAmount}\u{20B9}",
                      Icons.credit_card_rounded),
                ],
              ),
            ),
            Visibility(
              visible: widget.tripHistoryEntity.tripHistoryModel.isCompleted! &&
                  widget.tripHistoryEntity.tripHistoryModel.rating == 0.0,
              child: Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Received click');
                    _showRatingAppDialog();
                  },
                  child: const Text('Rate Your Journey'),
                  style: ButtonStyle(
                    backgroundColor:
                        widget.tripHistoryEntity.tripHistoryModel.isCompleted!
                            ? MaterialStateProperty.all(Colors.green)
                            : MaterialStateProperty.all(Colors.orange),
                  ),
                ),
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

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      starColor: Colors.amber,
      title: Text(widget.tripHistoryEntity.driverModel.name!,textAlign: TextAlign.center,),
      message: const Text('Rate Your Journey',textAlign: TextAlign.center,),
      image: const CircleAvatar(
        radius: 42,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage:  NetworkImage("https://images.unsplash.com/profile-1533651674518-3723fed8d396?dpr=1&auto=format&fit=crop&w=150&h=150&q=60&crop=faces&bg=fff"),
          radius: 40,
        ),
      ),
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');
        BlocProvider.of<TripHistoryCubit>(context).setRatingForDriver(response.rating,widget.tripHistoryEntity);
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}
