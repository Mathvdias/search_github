import 'package:multiple_result/multiple_result.dart';
import 'package:search_github/modules/search/domain/errors/errors.dart';
import 'package:search_github/modules/search/domain/entities/result_search.dart';
import 'package:search_github/modules/search/domain/repositories/search_repository.dart';
import 'package:search_github/modules/search/infra/datasources/search_datasource.dart';
import 'package:search_github/modules/search/infra/models/result_search_model.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<ResultSearch>, Failure>> search(String searchText) async {
    List<ResultSearchModel>? list;
    try {
      list = await dataSource.searchText(searchText);
    } catch (e) {
      Error(ErrorSearch());
    }
    return (list!.isEmpty) ? Error(DatasourceResultNull()) : Success(list);
  }
}
