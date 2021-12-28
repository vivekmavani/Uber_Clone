
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_driver_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_driver_app/presentation/cubit/trip_history/trip_history_cubit.dart';
import 'package:uber_driver_app/presentation/widgets/trip_history/loading_widget.dart';
import 'package:uber_driver_app/presentation/widgets/trip_history/message_display.dart';
import 'package:uber_driver_app/presentation/widgets/trip_history/trip_history_tile.dart';

class TripHistory extends StatefulWidget {
  const TripHistory({Key? key}) : super(key: key);

  @override
  State<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TripHistoryCubit>(context).getTripHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Your Trips"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<TripHistoryCubit, TripHistoryState>(
          builder: (context, state) {
            if (state is TripHistoryInitial) {
              return const MessageDisplay(
                message: 'History',
              );
            } else if (state is TripHistoryLoading) {
              return LoadingWidget();
            }else if (state is TripHistoryLoaded) {
              return _buildListWidget(context,state.tripHistoryList);
            }  else if (state is TripHistoryFailureState) {
              return MessageDisplay(
                message: state.message,
              );
            }
            return const MessageDisplay(
              message: 'History',
            );
          },
        ),
      ),
    );
  }

  Widget _buildListWidget(BuildContext context, List<TripDriver> tripHistoryList) {
    if (tripHistoryList.isEmpty) {
      return const MessageDisplay(
        message: 'Empty History',
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: ListView.builder(
            itemCount: tripHistoryList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
                return TripHistoryTile(tripHistoryEntity: tripHistoryList[index]);
            }),
      );
    }
  }
}
