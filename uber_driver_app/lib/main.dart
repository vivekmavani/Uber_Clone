import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uber_driver_app/presentation/cubit/driver_location/driver_location_cubit.dart';
import 'package:uber_driver_app/presentation/cubit/trip_history/trip_history_cubit.dart';
import 'package:uber_driver_app/presentation/cubit/user_req/user_req_cubit.dart';
import 'package:uber_driver_app/presentation/pages/trip_history/trip_history.dart';
import 'package:uber_driver_app/presentation/pages/user_req/user_req.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uber Driver',
      /*home: BlocProvider(
        create: (BuildContext context) => di.sl<TripHistoryCubit>(),
        child: TripHistory(),
      ),*/
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserReqCubit>(
            create: (BuildContext context) => di.sl<UserReqCubit>(),
          ),
          BlocProvider<DriverLocationCubit>(
            create: (BuildContext context) => di.sl<DriverLocationCubit>(),
          ),
        ],
        child: UserReq(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

}