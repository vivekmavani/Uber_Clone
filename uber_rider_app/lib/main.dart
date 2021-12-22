import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_rider_app/presentation/cubit/near_by_me/near_by_me_cubit.dart';
import 'package:uber_rider_app/presentation/cubit/trip_history/trip_history_cubit.dart';
import 'package:uber_rider_app/presentation/pages/near_by_me/near_by_me.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uber_rider_app/presentation/pages/trip_history/trip_history.dart';
import 'injection_container.dart' as di;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Near by me',
     /* home: BlocProvider(
        create: (BuildContext context) => di.sl<NearByMeCubit>(),
        child: NearByMe(),
      ),*/
      home: BlocProvider(
        create: (BuildContext context) => di.sl<TripHistoryCubit>(),
        child: TripHistory(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

}