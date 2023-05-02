part of 'cat_fact_bloc.dart';

abstract class CatFactState extends Equatable {
  const CatFactState();

  @override
  List<Object> get props => [];
}

class CatFactInitial extends CatFactState {}

class CatFactLoading extends CatFactState {}

class CatFactLoaded extends CatFactState {
  final CatFact catFact;

  const CatFactLoaded(this.catFact);

  @override
  List<Object> get props => [catFact];
}

class CatFactError extends CatFactState {
  final String message;

  const CatFactError(this.message);

  @override
  List<Object> get props => [message];
}
