import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uber_rider_app/core/error/near_by_me/failures.dart';

abstract class UseCase<Type, Params> {
  //Future<Either<Failure, Type>?>? call(Params params);
  Stream<Type>? call(Params params);
}

class NoParams extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
