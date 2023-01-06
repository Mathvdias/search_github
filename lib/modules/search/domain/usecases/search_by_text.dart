import 'package:multiple_result/multiple_result.dart';
import 'package:search_github/modules/search/domain/entities/result_search.dart';
import 'package:search_github/modules/search/domain/errors/errors.dart';
import 'package:search_github/modules/search/domain/repositories/search_repository.dart';

mixin SearchByText {
  Future<Result<List<ResultSearch>, Failure>> call(String searchText);
}

class SearchByTextImpl implements SearchByText {
  final SearchRepository repository;

  SearchByTextImpl(this.repository);
  @override
  Future<Result<List<ResultSearch>, Failure>> call(String searchText) async {
    final result = await repository.search(searchText);
    return result.when(
      (s) => Success(s),
      (e) => Error(e),
    );
  }
}
