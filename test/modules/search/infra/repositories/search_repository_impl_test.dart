import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_github/modules/search/domain/entities/result_search.dart';
import 'package:search_github/modules/search/external/datasources/github_datasource.dart';
import 'package:search_github/modules/search/infra/datasources/search_datasource.dart';
import 'package:search_github/modules/search/infra/repositories/search_repository_impl.dart';

class SearchDataSourceMock extends Mock implements SearchDataSource {}

void main() {
  final dio = Dio();
  final datasource = GithubDatasource(dio);
  final repository = SearchRepositoryImpl(datasource);
  test('deve retornar uma lista de ResultSearch', () async {
    final result = repository.search("Matheus");
    expect(result, isA<List<ResultSearch>>());
  });
}
