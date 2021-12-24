import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_driver_app/domain/entities/trip_history/trip_driver.dart';
import 'package:uber_driver_app/presentation/cubit/user_req/user_req_cubit.dart';
import 'package:uber_driver_app/presentation/widgets/trip_history/custom_elevated_button.dart';
import 'package:uber_driver_app/presentation/widgets/trip_history/loading_widget.dart';
import 'package:uber_driver_app/presentation/widgets/trip_history/message_display.dart';

class UserReq extends StatefulWidget {
  const UserReq({Key? key}) : super(key: key);

  @override
  _UserReqState createState() => _UserReqState();
}

class _UserReqState extends State<UserReq> {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modal Bottom Sheet',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: RaisedButton(
            child: Text("Show Rider Request"),
            onPressed: () {
              show();
            },
          ),
        ),
      ),
    );
  }

  void show() {
    showModalBottomSheet(
      isScrollControlled: true,
        barrierColor: Colors.transparent,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
        context: context,
        builder: (builder) {
          BlocProvider.of<UserReqCubit>(context).getUserReq();
          final cubit = BlocProvider.of<UserReqCubit>(context);
          return BlocProvider.value(
            value: cubit,
            child: BlocBuilder<UserReqCubit, UserReqState>(
              builder: (context, state) {
                if (state is UserReqInitial) {
                  return const MessageDisplay(
                    message: 'User Request',
                  );
                } else if (state is UserReqLoading) {
                  return LoadingWidget();
                } else if (state is UserReqLoaded) {
                  return Container(
                    height:  MediaQuery.of(context).size.height / 2,
                    margin: EdgeInsets.only(top: 16),
                    child: state.tripHistoryList.isEmpty == true ?
                    const MessageDisplay(
                      message: 'No request available',
                    ) :ListView.builder(
                            itemCount: state.tripHistoryList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  state.tripHistoryList[index].riderModel.name
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'source: ${state.tripHistoryList[index].tripHistoryModel.source}',
                                        overflow: TextOverflow.ellipsis),
                                    Text(
                                        'destination: ${state.tripHistoryList[index].tripHistoryModel.destination}',
                                        overflow: TextOverflow.ellipsis),
                                    Text(
                                        'travelling time: ${state.tripHistoryList[index].tripHistoryModel.travellingTime}',
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                                leading: Text(
                                    '${state.tripHistoryList[index].tripHistoryModel.tripAmount}\u{20B9}'),
                                trailing: CustomElevatedButton(
                                  onPressed: () {
                                       BlocProvider.of<UserReqCubit>(context).isAccept(state.tripHistoryList[index],true,false);
                                  },
                                  text: 'ACCEPT',
                                ),
                              );
                            }),
                  );
                } else if (state is UserReqFailureState) {
                  return MessageDisplay(
                    message: state.message,
                  );
                }else if(state is UserReqDisplayOne)
                  {
                    return Container(
                      height:  MediaQuery.of(context).size.height / 4,
                      margin: EdgeInsets.only(top: 16),
                      child: ListTile(
                        title: Text(
                          state.tripDriver.riderModel.name
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'source: ${state.tripDriver.tripHistoryModel.source}',
                                overflow: TextOverflow.ellipsis),
                            Text(
                                'destination: ${state.tripDriver.tripHistoryModel.destination}',
                                overflow: TextOverflow.ellipsis),
                            Text(
                                'travelling time: ${state.tripDriver.tripHistoryModel.travellingTime}',
                                overflow: TextOverflow.ellipsis),
                            CustomElevatedButton(
                              onPressed: () {
                                // update is_arrived = true
                                if(state.tripDriver.tripHistoryModel.isCompleted == false)
                                  {
                                    BlocProvider.of<UserReqCubit>(context).isAccept(state.tripDriver,false,false);
                                  }else
                                    {
                                      BlocProvider.of<UserReqCubit>(context).isAccept(state.tripDriver,false,false);
                                    }

                              },
                              text: state.tripDriver.tripHistoryModel.isArrived == false ? 'ARRIVED' :
                              state.tripDriver.tripHistoryModel.isCompleted == true ? 'ACCEPT PAYMENT' : 'COMPLETED',
                            ),
                          ],
                        ),
                        leading: Text(
                            '${state.tripDriver.tripHistoryModel.tripAmount}\u{20B9}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // call method
                          },
                          //arrived true and completed false -> ongoing
                          child: const Text(
                            'CALL',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                          ),
                        ),
                      ),
                    );
                  }
                return const MessageDisplay(
                  message: 'History',
                );
              },
            ),
          );
        });
  }
}
