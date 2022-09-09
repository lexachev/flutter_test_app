import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/usecases/search_person.dart';

// ignore: constant_identifier_names
const SERVER_FAILURE_MESSAGE = 'Server Failure';
// ignore: constant_identifier_names
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonSearchEmpty()) {
    on<PersonSearchEvent>((event, emit) async {
      emit(PersonSearchLoading());
      if (event is SearchPersons) {
        final failureOrPerson =
            await searchPerson(SearchPersonParams(query: event.personQuery));
        emit(failureOrPerson.fold(
            (failure) =>
                PersonSearchError(message: _mapFailureToMessage(failure)),
            (person) => PersonSearchLoaded(persons: person)));
      }
    });
  }

  // Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
  //   if (event is SearchPersons) {
  //     emit(_mapFetchPersonsToState(event.personQuery));
  //   }
  // }

  // Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
  //   emit(PersonSearchLoading());

  //   final failureOrPerson =
  //       await searchPerson(SearchPersonParams(query: personQuery));

  //   emit(failureOrPerson.fold(
  //       (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
  //       (person) => PersonSearchLoaded(persons: person)));
  // }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
