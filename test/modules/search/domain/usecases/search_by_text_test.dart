
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:search_github/modules/search/domain/repositories/search_repository.dart';
import 'package:search_github/modules/search/domain/usecases/search_by_text.dart';
import 'package:search_github/modules/search/external/datasources/github_datasource.dart';
import 'package:search_github/modules/search/infra/models/result_search_model.dart';
import 'package:search_github/modules/search/infra/repositories/search_repository_impl.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

void main() {
  final dio = Dio();
  final repository = SearchRepositoryImpl(GithubDatasource(dio));
  final usecase = SearchByTextImpl(repository);
  test('deve retornar uma lista de ResultSearch', () async {
    final result = usecase.call("matheus");
    expect(result, isA<List<ResultSearchModel>>());
  });
}
