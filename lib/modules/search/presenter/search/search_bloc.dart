import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_github/modules/search/domain/errors/errors.dart';
import 'package:search_github/modules/search/domain/usecases/search_by_text.dart';
import 'package:search_github/modules/search/presenter/search/states/state.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../infra/models/result_search_model.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

final Dio dio = Dio();

class SearchBloc extends Bloc<GithubSearchEvent, SearchState>
    implements Disposable {
  final SearchByText usecase;

  SearchBloc(this.usecase) : super(SearchStart()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  Future _onTextChanged(
    TextChanged event,
    Emitter<SearchState> emit,
  ) async {
    final searchTerm = event.text;

    if (searchTerm.isEmpty) return emit(SearchStart());

    emit(SearchLoading());

    final results = await usecase(searchTerm);
    results.when(
      (s) => emit(SearchSuccess(s as List<ResultSearchModel>)),
      (e) => emit(SearchError(ErrorSearch())),
    );
  }

  @override
  void dispose() {
    close();
  }
}

abstract class GithubSearchEvent extends Equatable {
  const GithubSearchEvent();
}

class TextChanged extends GithubSearchEvent {
  const TextChanged({required this.text});

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}
