import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../../api/cat_facts_api.dart';
import '../../models/cat_fact_hive.dart';

part 'cat_fact_event.dart';
part 'cat_fact_state.dart';

class CatFactBloc extends Bloc<CatFactEvent, CatFactState> {
  final CatFactsApi api;

  CatFactBloc(this.api) : super(CatFactInitial()) {
    on<LoadRandomCatFact>(_onLoadRandomCatFact);
  }

  _onLoadRandomCatFact(
      LoadRandomCatFact event, Emitter<CatFactState> emit) async {
    emit(CatFactLoading());
    try {
      final catFact = await api.getRandomFact();
      emit(CatFactLoaded(catFact));

      final catFactHive = CatFactHive.fromApi(catFact);
      final box = Hive.box<CatFactHive>('catFacts');
      await box.add(catFactHive);
    } catch (error) {
      emit(CatFactError(error.toString()));
    }
  }
}
