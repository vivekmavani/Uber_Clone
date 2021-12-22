
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<void>? call2(Params params);
  Stream<Type>? call(Params params);
}

class NoParams extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class Params extends Equatable {
  final Type type;

  Params({required this.type});

  @override
  List<Object> get props => [type];
}
