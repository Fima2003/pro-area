part of 'cat_fact_bloc.dart';

abstract class CatFactEvent extends Equatable {
  const CatFactEvent();

  @override
  List<Object> get props => [];
}

class LoadRandomCatFact extends CatFactEvent {}
